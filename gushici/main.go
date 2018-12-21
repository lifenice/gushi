package main

import (
	"./models"
	_ "./routers"

	"./../beego"
)

func main() {
	models.Init()
	beego.SetStaticPath("/uploads", "uploads")
	beego.Run()
}
