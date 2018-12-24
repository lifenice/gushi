package main

import (
	"./models"
	_ "./routers"

	"github.com/astaxie/beego"
)

func main() {
	models.Init()
	beego.SetStaticPath("/uploads", "uploads")
	beego.Run()
}
