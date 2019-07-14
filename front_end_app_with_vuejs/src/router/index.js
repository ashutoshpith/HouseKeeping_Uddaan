import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Products from '@/components/products/Products.vue'
import Tasks from '@/components/tasks/Tasks.vue'
import Workers from '@/components/workers/Workers.vue'
import Titus from '@/components/titus/Titus.vue'
import HelloWorld from '@/components/HelloWorld.vue'

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
      path: '/products',
      name: 'Products',
      component: Products
    },
    {
      path: '/titus',
      name: 'Titus',
      component: Titus
    },
    {
      path: '/tasks',
      name: 'Tasks',
      component: Tasks
    },
    {
      path: '/workers',
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
