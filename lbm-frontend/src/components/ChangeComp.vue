<template>
  <div class="change-container">
    <div class="form-group">
      <label>借阅编号:</label>
      <input type="text" :value ="recordId" disabled />
    </div>
    <div class="form-group">
      <label>归还数量:</label>
      <input type="number" v-model="newReturnCount"/>
    </div>
    <div class="form-group">
      <button class="submit-btn" @click="handleSubmit">确认修改</button>
    </div>
  </div>
</template>

<script>
import { lbmApi } from '../lbmapi/lbmapi'

export default {
  name: 'ChangeComp',
  props: {
    recordId: {
      type: String,
      required: true
    },
    returnTime: {
        type: String,
        required: true
    },
    returnCount: {
        type: Number,
        required: true
    }
  },
  data() {
    return{
        newReturnCount: this.returnCount
    }
  },
  methods: {
    async handleSubmit() {
      try {
        await lbmApi.changeRecord(this.recordId, this.returnTime, this.newReturnCount)
        this.$emit('close')
      } catch (error) {
        console.error('修改失败:', error)
      }

      alert("修改成功")
      this.$router.push('/records')
    }
  }
}
</script>

<style>
.change-container {
  padding: 20px;
}

.form-group {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
}

.form-group label {
  width: 100px;
  text-align: right;
  margin-right: 15px;
  color: #606266;
}

.form-group input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  font-size: 14px;
}

.form-group input:disabled {
  background-color: #f5f7fa;
  cursor: not-allowed;
}

.submit-btn {
  background-color: #409eff;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s;
}

.submit-btn:hover {
  background-color: #66b1ff;
}
</style>