<template>
  <div class="max-w-md m-auto py-10 container shadow-lg p-5 bg-dark rounded">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4 text-white">Add a new task</h3>

    <form @submit.prevent="addTask">
      <div class="mb-6 p-2">
        <label for="task_title" class="label text-white">Title</label><br>
        <input
          type="text"
          id="task_title"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a task name"
          v-model="newTask.name">
      </div>

      <div class="mb-6">
        <label for="product" class="label text-white">Assests</label><br>
        <select id="product" class="select pl-5" v-model="newTask.product">
          <option disabled value="">Select an assets</option>
          <option :value="product.id" v-for="product in products" :key="product.id">{{ product.name }}</option>
        </select>
        <p class="pt-4 text-white">Don't see an product? <router-link to="/products" class="link-grey">Create one</router-link></p>
    </div>

        <div class="mb-6">
    <label for="worker" class="label text-white">Workers</label><br>
    <select id="worker" class="select pl-5" v-model="newTask.worker">
        <option disabled value="">Select an workers</option>
        <option :value="worker.id" v-for="worker in workers" :key="worker.id">{{ worker.name }}</option>
    </select>
    <p class="pt-4 text-white">Don't see an worker? <router-link to="/workers" class="link-grey">Create one</router-link></p>
    </div>

      <input type="submit" value="Add task" class="btn btn-lg btn-danger">
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="task in tasks" :key="task.id" :task="task">
        <div class="flex items-center justify-between flex-wrap">
          <div class="flex-1 flex justify-between flex-wrap pr-4">
          <p class="block flex font-mono font-semibold flex items-center">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>task </title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" ></path></svg>
            {{ task.name }}
          </p>
          <p class="block font-mono font-semibold">{{ getProduct(task) }}</p>
          <p class="block font-mono font-semibold">{{ getWorker(task) }}</p>

        </div>

        <button class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editTask(task)">Edit</button>

        <button class="bg-transparent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeTask(task)">Delete</button>
        </div>

        <div v-if="task == editedTask">
          <form action="" @submit.prevent="updateTask(task)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">

              <div class="mb-6">
                <label class="label">Title</label>
                <input class="input" v-model="task.name">
              </div>

              <div class="mb-6">
                 <select id="product_update" class="select" v-model="task.product">
                    <option disabled value="">Select an product</option>
                  <option :value="product.id" v-for="product in products" :key="product.id">{{ product.name }}</option>
                  </select>
              </div>
            <div class="mb-6">
            <select id="worker_update" class="select" v-model="task.worker">
            <option disabled value="">Select an Worker</option>
            <option :value="worker.id" v-for="worker in workers" :key="worker.id">{{ worker.name }}</option>
            </select>
        </div>

              <input type="submit" value="Update" class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'tasks',
  data () {
    return {
      products: [],
      tasks: [],
      workers: [],
      newTask: [],
      error: '',
      editedTask: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/tasks')
        .then(response => { this.tasks = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/api/v1/products')
        .then(response => { this.products = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))

      this.$http.secured.get('/api/v1/workers')
        .then(response => { this.workers = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    getProduct (task) {
      const taskproductValues = this.products.filter(product => product.id === task.product_id)
      let product

      taskproductValues.forEach(function (element) {
        product = element.name
      })

      return product
    },
    getWorker (task) {
      const taskproductValues = this.workers.filter(worker => worker.id === task.worker_id)
      let worker

      taskproductValues.forEach(function (element) {
        worker = element.name
      })

      return worker
    },
    addTask () {
      const value = this.newTask
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/tasks/', { task: { title: this.newTask.name, product_id: this.newTask.product, worker_id: this.newTask.worker } })
        .then(response => {
          this.tasks.push(response.data)
          this.newTask = ''
        })
        .catch(error => this.setError(error, 'Cannot create task'))
    },
    removeTask (task) {
      this.$http.secured.delete(`/api/v1/tasks/${task.id}`)
        .then(response => {
          this.tasks.splice(this.tasks.indexOf(task), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete task'))
    },
    editTask (task) {
      this.editedTask = task
    },
    updateTask (task) {
      this.editedTask = ''
      this.$http.secured.patch(`/api/v1/tasks/${task.id}`, { task: { name: task.name, product_id: task.product, worker_id: task.worker } })
        .catch(error => this.setError(error, 'Cannot update task'))
    }
  }
}
</script>
