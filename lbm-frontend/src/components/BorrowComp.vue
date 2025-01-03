<template>
  <div class="borrow-container">
    <div class="borrow-form">
      <div class="form-group">
        <label>图书编号</label>
        <input type="text" v-model="bookId" placeholder="请输入图书编号">
      </div>
      <div class="form-group">
        <label>读者姓名</label>
        <input type="text" v-model="readerName" placeholder="请输入读者姓名">
      </div>
      <div class="form-group">
        <label>借阅数量</label>
        <input type="number" v-model="borrowCount" min="1">
      </div>
      <button class="submit-btn" @click="handleBorrow">提交借阅</button>
    </div>
  </div>
</template>

<script>
import { lbmApi } from '../lbmapi/lbmapi'

export default {
  data() {
    return {
      borrowTime: '',
      readerName: '',
      borrowCount: 1
    }
  },
  methods: {
    async handleBorrow() {
      const now = new Date(new Date().getTime() + 8 * 60 * 60 * 1000)
      const formattedDate = now.toISOString().slice(0, 19).replace('T', ' ')
      const response = await lbmApi.borrowBook(formattedDate, this.bookId, this.readerName, this.borrowCount)
      this.records = response.data

      alert("借阅成功")
      this.$router.push('/records')
    }
    
  }
}
</script>

<style>
.borrow-container {
  padding: 2rem;
  max-width: 800px;
  margin: 0 auto;
}

.page-title {
  color: #374151;
  margin-bottom: 2rem;
  font-weight: 600;
  font-size: 1.75rem;
}

.borrow-form {
  background: #ffffff;
  padding: 2.5rem;
  border-radius: 1rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  transition: transform 0.2s ease;
}

.borrow-form:hover {
  transform: translateY(-2px);
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  color: #4b5563;
  margin-bottom: 0.5rem;
  font-size: 0.95rem;
  font-weight: 500;
}

.form-group input {
  width: 100%;
  padding: 0.75rem 1rem;
  border: 1px solid #e5e7eb;
  border-radius: 0.5rem;
  font-size: 0.95rem;
  color: #4b5563;
  background: #f9fafb;
  transition: all 0.3s ease;
}

.form-group input:focus {
  outline: none;
  border-color: #6366f1;
  background: #ffffff;
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
}

.form-group input::placeholder {
  color: #9ca3af;
}

.submit-btn {
  background-color: #6366f1;
  color: white;
  border: none;
  padding: 0.875rem 2rem;
  border-radius: 0.5rem;
  cursor: pointer;
  font-size: 0.95rem;
  font-weight: 500;
  transition: all 0.3s ease;
  width: 100%;
}

.submit-btn:hover {
  background-color: #4f46e5;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(99, 102, 241, 0.2);
}

.submit-btn:active {
  transform: translateY(0);
}
</style>