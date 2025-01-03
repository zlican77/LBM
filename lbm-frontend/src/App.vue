<template>
  <div class="app-container">
    <nav class="navbar">
      <div class="nav-content">
        <div class="logo" @click="goToHome">
          图书借阅管理
        </div>
        <div class="nav-links">
          <router-link to="/books" class="nav-item">图书信息</router-link>
          <router-link to="/records" class="nav-item">借阅记录</router-link>
          <router-link to="/borrow" class="nav-item">借阅</router-link>
          <router-link to="/return" class="nav-item">归还</router-link>
        </div>
      </div>
    </nav>

    <main class="main-content">
      <router-view v-slot="{ Component }">
        <transition name="fade" mode="out-in">
          <component :is="Component" />
        </transition>
      </router-view>
    </main>
  </div>
</template>

<script>
import { useRouter } from 'vue-router'

export default {
  name: 'App',
  setup() {
    const router = useRouter()
    
    // 点击logo时返回首页,提供更好的用户体验
    const goToHome = () => {
      router.push('/')
    }
    return {
      goToHome
    }
  }
}
</script>

<style>
:root {
  --primary-color: #6366f1;
  --text-color: #374151;
  --bg-color: #ffffff;
  --nav-bg: #f3f4f6;
  --shadow-color: rgba(0, 0, 0, 0.1);
}

.dark {
  --primary-color: #818cf8;
  --text-color: #e5e7eb;
  --bg-color: #1f2937;
  --nav-bg: #111827;
  --shadow-color: rgba(0, 0, 0, 0.3);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  transition: background-color 0.3s, color 0.3s;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  color: var(--text-color);
  background-color: var(--bg-color);
  line-height: 1.5;
}

.app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background-color: var(--nav-bg);
  box-shadow: 0 2px 8px var(--shadow-color);
  padding: 0.75rem 0;
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 2rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--primary-color);
  cursor: pointer;
  padding: 0.5rem 0;
  margin-right: 3rem;
  letter-spacing: -0.5px;
}

.nav-links {
  display: flex;
  gap: 1.5rem;
  align-items: center;
}

.nav-item {
  text-decoration: none;
  color: var(--text-color);
  font-weight: 500;
  padding: 0.5rem 1rem;
  border-radius: 0.5rem;
  transition: all 0.2s ease;
}

.nav-item:hover {
  background-color: var(--primary-color);
  color: white;
  transform: translateY(-1px);
}

.nav-item.router-link-active {
  background-color: var(--primary-color);
  color: white;
  box-shadow: 0 2px 4px rgba(99, 102, 241, 0.2);
}

.theme-toggle {
  cursor: pointer;
  font-size: 1.25rem;
  padding: 0.5rem;
}

.main-content {
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
  flex: 1;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>