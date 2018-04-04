package main

import (
	"bufio"
	"fmt"
	"github.com/tebeka/selenium"
	_ "github.com/tebeka/selenium/firefox"
	"github.com/tebeka/selenium/log"
	"io/ioutil"
	"os"
)

func handleError(err error) {
	if err != nil {
		fmt.Printf("Failed to load page: %s\n", err)
		os.Exit(1)
	}
}

func main() {
	var webDriver selenium.WebDriver
	var err error
	caps := selenium.Capabilities{"browserName": "firefox"}
	caps.AddLogging(log.Capabilities{
		log.Browser: log.All,
		log.Client:  log.All,
		log.Server:  log.All,
	})
	webDriver, err = selenium.NewRemote(caps, "http://127.0.0.1:4444/wd/hub")
	handleError(err)
	defer webDriver.Quit()

	err = webDriver.SetAsyncScriptTimeout(60000)
	handleError(err)
	err = webDriver.SetImplicitWaitTimeout(60000)
	handleError(err)

	err = webDriver.Get("http://127.0.0.1:8000/services")
	handleError(err)

	title, _ := webDriver.Title()
	src, _ := webDriver.PageSource()

	fmt.Printf("Page title: %s\n", title)
	fmt.Printf("Page source: %s\n", src)

	elem, err := webDriver.FindElement(selenium.ByID, "mity-qrcode")
	handleError(err)
	img, err := elem.FindElement(selenium.ByTagName, "img")
	handleError(err)

	alt, err := img.GetAttribute("alt")
	handleError(err)

	fmt.Printf("%v\n", elem)
	fmt.Printf("%v\n", img)
	fmt.Printf("%v\n", alt)

	s, err := webDriver.Screenshot()
	ioutil.WriteFile("shot1.png", s, 0644)

	reader := bufio.NewReader(os.Stdin)
	_, _ = reader.ReadString('\n')

	s, err = webDriver.Screenshot()
	ioutil.WriteFile("shot2.png", s, 0644)
	_, _ = reader.ReadString('\n')

	s, err = webDriver.Screenshot()
	ioutil.WriteFile("shot3.png", s, 0644)
	_, _ = reader.ReadString('\n')

	items, err := webDriver.Log(log.Browser)
	for _, item := range items {
		fmt.Println(item.Message)
	}
	items, err = webDriver.Log(log.Client)
	for _, item := range items {
		fmt.Println(item.Message)
	}
	items, err = webDriver.Log(log.Server)
	for _, item := range items {
		fmt.Println(item.Message)
	}
}
