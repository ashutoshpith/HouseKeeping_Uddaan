<template>
  <div class="hello container shadow-lg p-5">
    <h1>{{ msg }}</h1>
    <p>It is created with ruby on rails in backend api and vuejs as frontend</p>
    <p>For Styling Bootstrap and tailwindcss used</p>
    <p>Admin login need to create task ,assets,and worker</p>
    <section class="row">
      <div class="col">
        <ul class="list-reset mt-4"><h1>Assets Available</h1>
      <li class="py-4" v-for="product in products" :key="product.id" :product="product">
        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music product</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            {{ product.name }}
          </p>
        </div>
      </li>
    </ul>
      </div>
      <div class="col">
 <ul class="list-reset mt-4"><h1>Workers Available</h1>
      <li class="py-4" v-for="worker in workers" :key="worker.id" :worker="worker">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music worker</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            <strong>Name-</strong> {{ worker.name }} <br><strong class="pl-4"> Skill Set </strong> {{ worker.skill_set }}
             </p>
        </div>
      </li>
    </ul>
      </div>
      <div class="col">
        <router-link to="/add-task" class=" px-2 no-underline btn btn-lg btn-block btn-success" v-if="signedIn()">Allocate Tasks</router-link>
      </div>
    </section>
 </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      products: [],
      workers: [],
      newProduct: [],
      error: '',
      editedProduct: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/products')
        .then(response => { this.products = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
      this.$http.secured.get('/api/v1/workerskills')
        .then(response => { this.workers = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
