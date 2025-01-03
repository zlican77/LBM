<template>
  <div class="books-container">
    <table class="books-table">
      <thead>
        <tr>
          <th>图书编号</th>
          <th>图书名称</th>
          <th>作者</th>
          <th>出版社</th>
          <th>馆藏数</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="book in books" :key="book.id">
          <td>{{book.bookId}}</td>
          <td>{{book.bookName}}</td>
          <td>{{book.author}}</td>
          <td>{{book.publisher}}</td>
          <td>{{book.stockCount}}</td>
        </tr>
      </tbody>
    </table>

    <PageChange 
      :currentPage="currentPage" 
      :totalPages="totalPages" 
      @page-change="handlePageChange" 
    />
  </div>
</template>

<script>
import { lbmApi } from '../lbmapi/lbmapi'
import PageChange from './PageChange.vue'

export default {
  components: {
    PageChange
  },
  data() {
    return {
      books: [
        {
          id: "B001",
          name: "Vue.js实战指南",
          author: "张三",
          publisher: "科技出版社",
          count: 5
        },
        {
          id: "B002", 
          name: "JavaScript高级程序设计",
          author: "李四",
          publisher: "工业出版社",
          count: 3
        }
      ],
      pageSize: 12,
      currentPage: 1,
      totalPages: 1,
      total: 0
    }
  },
  mounted() {
    this.fetchBooks()
  },
  methods: {
    async fetchBooks() {
      const response = await lbmApi.getBooks(this.currentPage, this.pageSize)
      this.books = response.data.books
      this.total = response.data.total
      this.totalPages = Math.ceil(this.total / this.pageSize)
    },
    async handlePageChange(page) {
      this.currentPage = page
      await this.fetchBooks()
    }
  }
}
</script>

<style>
.books-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  color: #2c3e50;
  margin-bottom: 30px;
  font-weight: 500;
}

.books-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.books-table th,
.books-table td {
  padding: 15px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.books-table th {
  background-color: #f8f9fa;
  color: #606266;
  font-weight: 500;
}

.books-table tr:hover {
  background-color: #f5f7fa;
}

.books-table td {
  color: #606266;
}
</style>