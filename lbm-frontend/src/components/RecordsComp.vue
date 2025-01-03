<template>
  <div class="records-container">
    <table class="records-table">
      <thead>
        <tr>
          <th class="col-id">借阅编号</th>
          <th class="col-bookid">图书编号</th>
          <th class="col-bookname">图书名称</th>
          <th class="col-reader">读者名称</th>
          <th class="col-time">借阅时间</th>
          <th class="col-time">归还时间</th>
          <th class="col-count">借阅数量</th>
          <th class="col-status">借阅状态</th>
          <th class="col-action">管理操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="record in records" :key="record.id">
          <td>{{record.id}}</td>
          <td>{{record.bookId}}</td>
          <td>{{record.bookName}}</td>
          <td>{{record.readerName}}</td>
          <td class="wrap-text">{{record.borrowTime}}</td>
          <td class="wrap-text">{{record.returnTime}}</td>
          <td>{{ record.borrowCount }}</td>
          <td class="wrap-text">
            <span :class="['status-tag', /归还/.test(record.status) ? 'returned' : 'borrowing']">
              {{record.status}}
            </span>
          </td>
          <td class="wrap-text">
            <button class="action-btn edit" @click="clickEdit(record)">修改</button>
            <button class="action-btn delete" @click="clickDelete(record)">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <PageChange 
      :currentPage="currentPage" 
      :totalPages="totalPages" 
      @page-change="handlePageChange" 
    />

    <!-- 修改弹窗 -->
    <div class="dialog-overlay" v-if="editDialogVisible">
      <div class="close-btn" @click=handleClose>×</div>
      <el-dialog
        v-model="editDialogVisible"
        title="修改借阅记录" 
        width="50%"
        :before-close="handleClose"
        class="floating-dialog">
        <ChangeComp v-if="editDialogVisible" :recordId="currentRecordId" :returnCount="returnCount" :returnTime="returnTime"/>
      </el-dialog>
    </div>

  </div>
</template>

<script>
import { lbmApi } from '../lbmapi/lbmapi'
import ChangeComp from './ChangeComp.vue'
import PageChange from './PageChange.vue';

export default {
  components: {
    ChangeComp,
    PageChange
  },
  data() {
    return {
      records: [],
      pageSize: 9,
      currentPage: 1,
      totalPages: 1,
      total: 0,

      editDialogVisible: false,
      deleteDialogVisible: false,
      currentRecordId: '',
      recordToDelete: null,
      returnCount: 0,
      returnTime: ''
    }
  },
  mounted() {
    this.fetchRecords()
  },
  methods: {
    async fetchRecords() {
      const response = await lbmApi.getRecords(this.currentPage, this.pageSize)
      response.data.records.forEach(record => {
        record.borrowTime = record.borrowTime.replace('T', ' ').substring(0, 16)
        if(record.returnTime) {
          record.returnTime = record.returnTime.replace('T', ' ').substring(0, 16)
        }
      })
      this.records = response.data.records
      this.total = response.data.total
      this.totalPages = Math.ceil(this.total / this.pageSize)
    },
    async handlePageChange(page) {
      this.currentPage = page
      await this.fetchRecords()
    },

    // 修改借阅记录
    async clickEdit(record) {
      this.currentRecordId = record.id
      this.returnCount = record.returnCount
      this.returnTime = record.returnTime
      this.editDialogVisible = true
    },
    handleClose() {
      this.editDialogVisible = false
      this.currentRecordId = ''
      this.fetchRecords()
    },
    async clickDelete(record) {
      alert("确定删除" + record.id + "吗？")
      this.recordToDelete = record
      this.handleDelete()
    },
    async handleDelete() {
      await lbmApi.deleteRecord(this.recordToDelete.id, this.recordToDelete.returnTime)
      this.fetchRecords()

      alert("删除成功")
      this.$router.push('/records')
    },

  }
}
</script>

<style>
.records-container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}

.page-title {
  color: #2c3e50;
  margin-bottom: 30px;
  font-weight: 500;
  font-size: 24px;
}

.records-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  table-layout: fixed;
}

.records-table th,
.records-table td {
  padding: 15px;
  text-align: center;
  border-bottom: 1px solid #ebeef5;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.records-table td.wrap-text {
  white-space: normal;
  word-break: break-word;
}

.records-table th {
  background-color: #f8f9fa;
  color: #606266;
  font-weight: 500;
  font-size: 14px;
}

.records-table tr:hover {
  background-color: #f5f7fa;
}

.records-table td {
  color: #606266;
  font-size: 14px;
}

/* 列宽设置 */
.col-id {
  width: 18%;
}

.col-bookid {
  width: 9%;
}

.col-bookname {
  width: 17%;
}

.col-reader {
  width: 9%;
}

.col-time {
  width: 11.5%;
}

.col-count {
  width: 9%;
}

.col-status {
  width: 12%;
}

.col-action {
  width: 13%;
}

.status-tag {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
}

.status-tag.returned {
  background-color: #c2e7b0;
  color: #2d7810;
}

.status-tag.borrowing {
  background-color: #f963a9;
  color: #fbf1f1;
}

.action-btn {
  padding: 4px 8px;
  margin: 0 4px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.3s;
}

.action-btn.edit {
  background-color: #409eff;
  color: white;
}

.action-btn.edit:hover {
  background-color: #66b1ff;
}

.close-btn {
      position: absolute;
      right: 10px;
      top: 10px;
      width: 30px;
      height: 30px;
      line-height: 30px;
      text-align: center;
      cursor: pointer;
      background: #fff;
      border-radius: 50%;
      font-size: 20px;
      z-index: 1000;
    }
    .close-btn:hover {
      background: #f5f5f5;
    }
.action-btn.delete {
  background-color: #f56c6c;
  color: white;
}

.action-btn.delete:hover {
  background-color: #f78989;
}

.dialog-footer {
  margin-top: 20px;
  text-align: right;
}

.dialog-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  z-index: 9999;
  display: flex;
  justify-content: center;
  align-items: center;
}

.floating-dialog {
  position: relative;
  z-index: 10000;
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}
</style>