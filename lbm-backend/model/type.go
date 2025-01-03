package model

type Book struct {
	BookId     string `json:"bookId" gorm:"column:book_id;type:char(4);primary_key"`
	BookName   string `json:"bookName" gorm:"column:book_name;type:varchar(20);not null"`
	Author     string `json:"author" gorm:"column:author;type:varchar(10)"`
	Publisher  string `json:"publisher" gorm:"column:publisher;type:varchar(20)"`
	StockCount int    `json:"stockCount" gorm:"column:stock_count;type:decimal(9,0);default:0"`
}

type BorrowRecord struct {
	BorrowTime  string `json:"borrowTime" gorm:"column:borrow_time;type:datetime;not null;primary_key"`
	BookId      string `json:"bookId" gorm:"column:book_id;type:char(4);not null;primary_key"`
	ReaderName  string `json:"readerName" gorm:"column:reader_name;type:varchar(10);not null"`
	BorrowCount int    `json:"borrowCount" gorm:"column:borrow_count;type:decimal(9,0);default:1"`
}

type ReturnRecord struct {
	RecordId    string `json:"recordId" gorm:"column:record_id;type:char(36);not null;primary_key"`
	ReturnCount int    `json:"returnCount" gorm:"column:return_count;type:decimal(9,0);default:1"`
	ReturnTime  string `json:"returnTime" gorm:"column:return_time;type:datetime;not null;primary_key"`
	Remark      string `json:"remark" gorm:"column:remark;type:varchar(20)"`
}

type BorrowRecordView struct {
	RecordId    string `json:"id" gorm:"column:record_id"`
	BookId      string `json:"bookId" gorm:"column:book_id"`
	BookName    string `json:"bookName" gorm:"column:book_name"`
	ReaderName  string `json:"readerName" gorm:"column:reader_name"`
	BorrowTime  string `json:"borrowTime" gorm:"column:borrow_time"`
	ReturnCount int    `json:"returnCount" gorm:"column:return_count"`
	ReturnTime  string `json:"returnTime" gorm:"column:return_time"`
	BorrowCount int    `json:"borrowCount" gorm:"column:borrow_count"`
	Status      string `json:"status" gorm:"column:status"`
}
