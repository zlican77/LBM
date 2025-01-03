package controller

import (
	"fmt"
	"lbm/config"
	"lbm/model"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

func GetBooks(c *gin.Context) {
	page, _ := strconv.Atoi(c.DefaultQuery("page", "1"))
	pageSize, _ := strconv.Atoi(c.DefaultQuery("pageSize", "12"))
	var total int64
	config.DB.Model(&model.Book{}).Count(&total)

	var books []model.Book
	result := config.DB.Offset((page - 1) * pageSize).Limit(pageSize).Find(&books)
	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}
	c.JSON(200, gin.H{
		"books": books,
		"total": total,
	})
}

func GetRecords(c *gin.Context) {
	page, _ := strconv.Atoi(c.DefaultQuery("page", "1"))
	pageSize, _ := strconv.Atoi(c.DefaultQuery("pageSize", "12"))
	var total int64
	config.DB.Table("v_borrow_records").Count(&total)

	var records []model.BorrowRecordView
	result := config.DB.Table("v_borrow_records").Offset((page - 1) * pageSize).Limit(pageSize).Find(&records)
	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}
	c.JSON(200, gin.H{
		"records": records,
		"total":   total,
	})
}

func BorrowBook(c *gin.Context) {
	borrowTime := c.Param("borrowTime")
	bookId := c.Param("bookId")
	readerName := c.Param("readerName")
	borrowCount := c.Param("borrowCount")
	borrowCountInt, err := strconv.Atoi(borrowCount)
	if err != nil {
		c.JSON(400, gin.H{"error": "Invalid borrow count"})
		return
	}

	record := model.BorrowRecord{
		BorrowTime:  borrowTime,
		BookId:      bookId,
		ReaderName:  readerName,
		BorrowCount: borrowCountInt,
	}

	result := config.DB.Create(&record)
	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}
	c.JSON(200, record)
}

func ReturnBook(c *gin.Context) {
	recordId := c.Param("recordId")
	returnCount := c.Param("returnCount")
	returnCountInt, err := strconv.Atoi(returnCount)
	if err != nil {
		c.JSON(400, gin.H{"error": "Invalid return count"})
		return
	}
	returnTime := c.Param("returnTime")
	remark := c.Param("remark")

	record := model.ReturnRecord{
		RecordId:    recordId,
		ReturnCount: returnCountInt,
		ReturnTime:  returnTime,
		Remark:      remark,
	}

	result := config.DB.Create(&record)
	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}
	c.JSON(200, record)
}

func ChangeRecord(c *gin.Context) {
	recordId := c.Param("recordId")
	returnTime := c.Param("returnTime")
	// 将URL编码的时间格式转换为数据库格式
	returnTime = strings.ReplaceAll(returnTime, "%20", " ")
	returnTime = strings.ReplaceAll(returnTime, "%3A", ":")
	returnCount := c.Param("returnCount")
	returnCountInt, err := strconv.Atoi(returnCount)
	if err != nil {
		c.JSON(400, gin.H{"error": "Invalid return count"})
		return
	}

	fmt.Println(recordId, returnTime, returnCountInt)

	result := config.DB.Model(&model.ReturnRecord{}).
		Where("record_id = ? AND DATE_FORMAT(return_time, '%Y-%m-%d %H:%i') = ?",
			recordId, returnTime).
		Update("return_count", returnCountInt)

	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}

	if result.RowsAffected == 0 {
		c.JSON(404, gin.H{"error": "记录未找到"})
		return
	}

	c.JSON(200, gin.H{"message": "修改成功"})
}

func DeleteRecord(c *gin.Context) {
	recordId := c.Param("recordId")
	returnTime := c.Param("returnTime")
	returnTime = strings.ReplaceAll(returnTime, "%20", " ")
	returnTime = strings.ReplaceAll(returnTime, "%3A", ":")

	result := config.DB.Delete(&model.ReturnRecord{}, "record_id = ? AND DATE_FORMAT(return_time, '%Y-%m-%d %H:%i') = ?",
		recordId, returnTime)
	if result.Error != nil {
		c.JSON(500, gin.H{"error": result.Error.Error()})
		return
	}

	c.JSON(200, gin.H{"message": "删除成功"})
}
