import request from './config'


export const lbmApi = {
    getBooks(page = 1, pageSize = 12) {
        return request({
            url: `/books?page=${page}&pageSize=${pageSize}`,
            method: 'get'
        })
    },
    getRecords(page = 1, pageSize = 12) {
        return request({
            url: `/records?page=${page}&pageSize=${pageSize}`,
            method: 'get'
        })
    },
    borrowBook(borrowTime, bookId, readerName, borrowCount) {
        return request({
            url: `/borrow/${borrowTime}/${bookId}/${readerName}/${borrowCount}`,
            method: 'post'
        })
    },
    returnBook(recordId, returnCount, returnTime, remark) {
        return request({
            url: `/return/${recordId}/${returnCount}/${returnTime}/${remark}`,
            method: 'post'
        })
    },
    changeRecord(recordId, returnTime, returnCount) {
        return request({
            url: `/changeRecord/${recordId}/${returnTime}/${returnCount}`,
            method: 'post'
        })
    },
    deleteRecord(recordId, returnTime) {
        return request({
            url: `/deleteRecord/${recordId}/${returnTime}`,
            method: 'post'
        })
    }
}