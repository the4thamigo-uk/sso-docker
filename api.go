package ssodocker

import (
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"os/exec"
	"path"
	"runtime"
	"strings"
)

type OpSys string

const (
	Ubuntu OpSys = "ubuntu"
	Centos       = "centos"
)

type Host string

const (
	SSO    = "sso"
	Consul = "consul"
	Statsd = "statsd"
	Redis  = "redis"
	LDAP   = "ldap"
	SysLog = "syslog"
	SP     = "sp"
)

type Repo string

const (
	Prd = "prd"
	Dev = "dev"
)

type Context struct {
	OpSys  OpSys
	Env    []string
	Stdlog io.Writer
	Stdout io.Writer
	Stderr io.Writer
}

func New(opSys OpSys) *Context {
	return &Context{
		OpSys: opSys,
	}
}

func (ctx *Context) Command(cmd string, opts ...string) (string, error) {
	ctx.log("Running Command : `%v %v` in %v", cmd, strings.Join(opts, " "), ctx.path())
	defer func() { ctx.log("Finished Command") }()

	c := exec.Command(cmd, opts...)
	c.Dir = ctx.path()
	c.Env = ctx.env()

	var out bytes.Buffer
	ctx.SetStdout(&out)

	c.Stdout = ctx.stdout()
	c.Stderr = ctx.stderr()

	err := c.Run()
	return string(out.Bytes()), err
}

func (ctx *Context) Up(services ...Host) (string, error) {
	return ctx.Command("./compose.sh", prepend(strHosts(services), "up", "-d")...)
}

func (ctx *Context) Down(services ...Host) (string, error) {
	return ctx.Command("./compose.sh", prepend(strHosts(services), "down")...)
}

func (ctx *Context) Repo(repo Repo) (string, error) {
	return ctx.Command("./repo.sh", string(repo))
}

func (ctx *Context) Install(pkg string, version string) (string, error) {
	return ctx.Command("./install.sh", pkg, version)
}

func (ctx *Context) Generate(tmplFile string) (string, error) {
	return ctx.Command("../config/generate.sh", tmplFile)
}

func (ctx *Context) Copy(dest string, src ...string) (string, error) {
	return ctx.Command("./cp.sh", append(src, dest)...)
}

func (ctx *Context) Service(name string, action string) (string, error) {
	return ctx.Command("./service.sh", name, action)
}

func (ctx *Context) Version(name string) (string, error) {
	return ctx.Command("./version.sh", name)
}

func (ctx *Context) Redis(action string) (string, error) {
	return ctx.Command("./redis.sh", action)
}

func (ctx *Context) path() string {
	return AbsPath(string(ctx.OpSys))
}

func (ctx *Context) env() []string {
	return append(append([]string{}, os.Environ()...), ctx.Env...)
}

func (ctx *Context) logErr(err error) {
	if err == nil {
		return
	}
	ctx.log(err.Error())
}

func (ctx *Context) log(msg string, args ...interface{}) {
	s := fmt.Sprintf(msg+"\n", args...)
	ctx.stdlog().Write([]byte(s))
}

func (ctx *Context) stdlog() io.Writer {
	if ctx.Stdlog != nil {
		return ctx.Stdlog
	}
	return ioutil.Discard
}

func (ctx *Context) stdout() io.Writer {
	if ctx.Stdout != nil {
		return ctx.Stdout
	}
	return ioutil.Discard
}

func (ctx *Context) stderr() io.Writer {
	if ctx.Stdout != nil {
		return ctx.Stderr
	}
	return ioutil.Discard
}

func thisDir() string {
	_, filename, _, _ := runtime.Caller(1)
	return path.Dir(filename)
}

func AbsPath(p string) string {
	return path.Join(thisDir(), p)
}

func prepend(after []string, before ...string) []string {
	return append(before, after...)
}

func strHosts(svs []Host) []string {
	s := []string{}
	for _, sv := range svs {
		s = append(s, string(sv))
	}
	return s
}

func (ctx *Context) SetStdout(newOut io.Writer) func() {
	if newOut == nil {
		return func() {}
	}
	oldOut := ctx.Stdout
	ctx.Stdout = io.MultiWriter(newOut, ctx.stdout())
	return func() {
		ctx.Stdout = oldOut
	}
}

func (ctx *Context) SetStderr(newErr io.Writer) func() {
	if newErr == nil {
		return func() {}
	}
	oldErr := ctx.Stderr
	ctx.Stderr = io.MultiWriter(newErr, ctx.stderr())
	return func() {
		ctx.Stderr = oldErr
	}
}
