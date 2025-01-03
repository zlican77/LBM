import { createRouter, createWebHistory } from 'vue-router'

import HomeComp from '../components/HomeComp.vue'
import BooksComp from '../components/BooksComp.vue'
import RecordsComp from '../components/RecordsComp.vue'
import BorrowComp from '../components/BorrowComp.vue'
import ReturnComp from '../components/ReturnComp.vue'

const routes = [
    { path: '/', component: HomeComp },
    { path: '/books', component: BooksComp },
    { path: '/records', component: RecordsComp },
    { path: '/borrow', component: BorrowComp },
    { path: '/return', component: ReturnComp },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router