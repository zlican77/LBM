<template>
    <div class="pagination">
      <button 
        :disabled="currentPage === 1"
        @click="$emit('page-change', currentPage - 1)"
      >上一页</button>
      <span>第 {{currentPage}} 页 / 共 {{totalPages}} 页</span>
      <button 
        :disabled="currentPage === totalPages"
        @click="$emit('page-change', currentPage + 1)"
      >下一页</button>
    </div>
</template>

<script>
export default {
    props: {
        currentPage: {
            type: Number,
            required: true
        },
        totalPages: {
            type: Number,
            required: true
        }
    },
    emits: ['page-change']
}
</script>

<style>
.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
}

.pagination button {
  padding: 8px 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background: white;
  cursor: pointer;
}

.pagination button:disabled {
  background: #f5f5f5;
  cursor: not-allowed;
}

</style>