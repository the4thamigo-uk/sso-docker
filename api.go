package ssodocker

import (
	"fmt"
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

type Service string

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
	Prod = "prd"
	Dev  = "dev"
)

type Context struct {
	OpSys  OpSys
	Env    []string
	Stdout *os.File
	Stderr *os.File
}

func (ctx Context) Command(cmd string, opts ...string) error {
	ctx.log(string(ctx.OpSys))
	ctx.log("Running Command : `%v %v` in %v", cmd, strings.Join(opts, " "), ctx.path())
	defer func() { ctx.log("Finished Command") }()

	c := exec.Command(cmd, opts...)
	c.Dir = ctx.path()
	c.Env = ctx.env()
	out, err := c.CombinedOutput()
	ctx.log(string(out))
	ctx.logErr(err)
	return err
}

func (ctx Context) Up(services ...Service) error {
	return ctx.Command("./compose.sh", prepend(strServices(services), "up", "-d")...)
}

func (ctx Context) Down(services ...Service) error {
	return ctx.Command("./compose.sh", prepend(strServices(services), "down")...)
}

func (ctx Context) Repo(repo Repo) error {
	return ctx.Command("./repo.sh", string(repo))
}

func (ctx Context) Install(pkg string, version string) error {
	return ctx.Command("./install.sh", pkg, version)
}

func thisDir() string {
	_, filename, _, _ := runtime.Caller(1)
	return path.Dir(filename)
}

func absPath(p string) string {
	return path.Join(thisDir(), p)
}

func prepend(after []string, before ...string) []string {
	return append(before, after...)
}

func (ctx Context) logErr(err error) {
	if err == nil {
		return
	}
	ctx.log(err.Error())
}

func (ctx Context) path() string {
	return absPath(string(ctx.OpSys))
}

func (ctx Context) env() []string {
	return append(append([]string{}, os.Environ()...), ctx.Env...)
}

func (ctx Context) log(msg string, args ...interface{}) {
	s := fmt.Sprintf(msg+"\n", args...)
	ctx.stdout().WriteString(s)
}

func (ctx Context) stdout() *os.File {
	if ctx.Stdout != nil {
		return ctx.Stdout
	}
	return os.Stdout
}

func (ctx Context) stderr() *os.File {
	if ctx.Stdout != nil {
		return ctx.Stderr
	}
	return os.Stderr
}

func strServices(svs []Service) []string {
	s := []string{}
	for _, sv := range svs {
		s = append(s, string(sv))
	}
	return s
}
