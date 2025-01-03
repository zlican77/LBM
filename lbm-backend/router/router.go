package router

import (
	"lbm/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter(r *gin.Engine) {
	rapi := r.Group("/lbmapi")
	{
		rapi.GET("/books", controller.GetBooks)
		rapi.GET("/records", controller.GetRecords)
		rapi.POST("/borrow/:borrowTime/:bookId/:readerName/:borrowCount", controller.BorrowBook)
		rapi.POST("/return/:recordId/:returnCount/:returnTime/:remark", controller.ReturnBook)
		rapi.POST("/changeRecord/:recordId/:returnTime/:returnCount", controller.ChangeRecord)
		rapi.POST("/deleteRecord/:recordId/:returnTime", controller.DeleteRecord)
	}
}
