<template>
  <div class="home-container">
    <h2 class="welcome-title">欢迎使用图书借阅管理系统</h2>
    <div class="welcome-content">
      <p class="welcome-text">这是一个现代化的图书管理平台</p>
      <p class="welcome-desc">您可以在这里进行图书借阅、归还等操作</p>
      <div class="feature-list">
        <div class="feature-item">
          <h3>图书借阅</h3>
          <p>快速便捷的借阅流程</p>
        </div>
        <div class="feature-item">
          <h3>图书归还</h3>
          <p>简单高效的归还管理</p>
        </div>
        <div class="feature-item">
          <h3>借阅记录</h3>
          <p>完整的借阅历史查询</p>
        </div>
      </div>
      <div class="system-info">
        <p>系统特点:</p>
        <ul>
          <li>界面简洁直观</li>
          <li>操作便捷高效</li>
          <li>数据实时同步</li>
          <li>安全可靠稳定</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HomeComp',
  data() {
    return {
      systemVersion: '1.0.0'
    }
  }
}
</script>

<style>
.home-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  text-align: center;
  background: linear-gradient(to bottom, #f8f9fa, #ffffff);
  min-height: 100vh;
}

.welcome-title {
  color: #2c3e50;
  font-size: 2.5rem;
  font-weight: 600;
  margin-bottom: 2rem;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
  letter-spacing: 1px;
}

.welcome-content {
  background: rgba(255, 255, 255, 0.95);
  padding: 3rem;
  border-radius: 1.5rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
  backdrop-filter: blur(10px);
  transition: transform 0.3s ease;
}

.welcome-content:hover {
  transform: translateY(-5px);
}

.welcome-text {
  color: #3a4f6c;
  font-size: 1.5rem;
  margin-bottom: 1.2rem;
  font-weight: 500;
}

.welcome-desc {
  color: #6b7c93;
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 3rem;
}

.feature-list {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
  margin: 3rem 0;
}

.feature-item {
  padding: 2rem;
  background: rgba(255, 255, 255, 0.7);
  border-radius: 1rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.feature-item:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
}

.feature-item h3 {
  color: #2c3e50;
  font-size: 1.3rem;
  margin-bottom: 1rem;
  font-weight: 600;
}

.feature-item p {
  color: #6b7c93;
  font-size: 1rem;
  line-height: 1.5;
}

.system-info {
  margin-top: 3rem;
  padding: 2rem;
  background: rgba(248, 249, 250, 0.8);
  border-radius: 1rem;
}

.system-info p {
  color: #3a4f6c;
  font-size: 1.2rem;
  font-weight: 500;
  margin-bottom: 1rem;
}

.system-info ul {
  list-style: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

.system-info li {
  color: #6b7c93;
  padding: 0.8rem;
  background: white;
  border-radius: 0.8rem;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  transition: all 0.2s ease;
}

.system-info li:hover {
  transform: scale(1.05);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
</style>