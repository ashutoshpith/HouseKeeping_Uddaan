import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Products from '@/components/products/Products.vue'
import Tasks from '@/components/tasks/Tasks.vue'
import Workers from '@/components/workers/Workers.vue'
import HelloWorld from '@/components/HelloWorld.vue'
import Assetsall from '@/components/Assetsall.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/assets/all',
      name: 'Assetsall',
      component: Assetsall
    },
    {
      path: '/add-asset',
      name: 'Products',
      component: Products
    },
    {
      path: '/add-task',
      name: 'Tasks',
      component: Tasks
    },
    {
      path: '/add-worker',
      name: 'Workers',
      component: Workers
    },
    {
      path: '/signin',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    }
  ]
})
