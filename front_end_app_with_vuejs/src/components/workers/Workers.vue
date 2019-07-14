<template class="container">

  <div class="max-w-md m-auto py-10 container shadow-lg p-5 bg-dark rounded">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4 text-white">Add a new worker</h3>
    <form action="" @submit.prevent="addWorker">
      <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Type an Worker name"
          v-model="newWorker.name" />
      </div>
      <br>
        <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Type an Skill Set "
          v-model="newWorker.skill_set" />
      </div><br/>
      <input type="submit" value="Add worker" class="btn btn-lg btn-primary text-dark" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="worker in workers" :key="worker.id" :worker="worker">

        <div class="flex items-center justify-between flex-wrap text-white">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music worker</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            <strong>Name-</strong> {{ worker.name }} <br><strong class="pl-4"> Skill Set </strong> {{ worker.skill_set }}
             </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editWorker(worker)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeWorker(worker)">Delete</button>
        </div>

        <div v-if="worker == editedWorker">
          <form action="" @submit.prevent="updateWorker(worker)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="worker.name" />
              <input type="submit" value="Update" class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: 'workers',
  data () {
    return {
      workers: [],
      newWorker: [],
      error: '',
      editedWorker: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/workerskills')
        .then(response => { this.workers = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addWorker () {
      const value = this.newWorker
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/workerskills/', { worker: { name: this.newWorker.name, skill_set: this.newWorker.skill_set } })

        .then(response => {
          this.workers.push(response.data)
          this.newWorker = ''
        })
        .catch(error => this.setError(error, 'Cannot create worker'))
    },
    removeWorker (worker) {
      this.$http.secured.delete(`/api/v1/workerskills/${worker.id}`)
        .then(response => {
          this.workers.splice(this.workers.indexOf(worker), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete worker'))
    },
    editWorker (worker) {
      this.editedWorker = worker
    },
    updateWorker (worker) {
      this.editedWorker = ''
      this.$http.secured.patch(`/api/v1/workerskills/${worker.id}`, { worker: { name: worker.name, skill_set: worker.skill_set } })
        .catch(error => this.setError(error, 'Cannot update worker'))
    }
  }
}
</script>
