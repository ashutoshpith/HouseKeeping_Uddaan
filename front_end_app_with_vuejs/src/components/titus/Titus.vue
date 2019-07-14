<template>
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new record</h3>

    <form @submit.prevent="addTitu">
      <div class="mb-6">
        <label for="name" class="label">Name</label>
        <input
          type="text"
          id="name"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a record name"
          v-model="newTitu.name">
      </div>
      <div class="mb-6">
        <label for="age" class="label">Age</label>
        <input
          type="text"
          id="age"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Age"
          v-model="newTitu.age">
      </div>
      <input type="submit" value="Add Record" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="titu in titus" :key="titu.id" :titu="titu">
        <div class="flex items-center justify-between flex-wrap">
          <div class="flex-1 flex justify-between flex-wrap pr-4">
          <p class="block flex font-mono font-semibold flex items-center">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>Titu</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" ></path></svg>
            {{ titu.name }} &mdash; {{ titu.age }}
          </p>
          <p class="block font-mono font-semibold">{{ getTitu(titu) }}</p>
        </div>

        <button class="bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editTitu(titu)">Edit</button>

        <button class="bg-transparent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeTitu(titu)">Delete</button>
        </div>

        <div v-if="titu == editedTitu">
          <form action="" @submit.prevent="updateTitu(titu)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">

              <div class="mb-6">
                <label class="label">Title</label>
                <input class="input" v-model="titu.name">
              </div>

              <div class="mb-6">
                <label class="label">Year</label>
                <input class="input" v-model="titu.age">
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
  name: 'Titus',
  data () {
    return {
      artists: [],
      titus: [],
      newTitu: [],
      error: '',
      editedTitu: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/v1/titus')
        .then(response => { this.titus = response.data })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addTitu () {
      const value = this.newTitu
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/titus/', { titu: { name: this.newTitu.name, age: this.newTitu.age } })

        .then(response => {
          this.titus.push(response.data)
          this.newTitu = ''
        })
        .catch(error => this.setError(error, 'Cannot create record'))
    },
    removeTitu (record) {
      this.$http.secured.delete(`/api/v1/titus/${record.id}`)
        .then(response => {
          this.titus.splice(this.titus.indexOf(record), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete record'))
    },
    editTitu (record) {
      this.editedTitu = record
    },
    updateTitu (record) {
      this.editedTitu = ''
      this.$http.secured.patch(`/api/v1/titus/${record.id}`, { titu: { name: record.name, age: record.age } })
        .catch(error => this.setError(error, 'Cannot update record'))
    }
  }
}
</script>
