
<template class="container">
  <header class="bg-grey-lighter py-4 container">
    <div class=" mr-auto flex flex-wrap items-center justify-end">
      <div class="flex-1 flex items-center">
          <title>House Keeping</title>

      </div>
      <ul>
        <a href="/" class="mr-auto uppercase btn btn-info pl-4">House Keeping</a>
        <a href="/" class="mr-auto uppercase btn btn-info">Home</a>
        <router-link to="/signin" class=" px-2  btn btn-info" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class=" px-2 no-underline btn btn-info" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/add-asset" class=" px-2 no-underline btn btn-info" v-if="signedIn()">Products</router-link>
        <router-link to="/add-task" class=" px-2 no-underline btn btn-info" v-if="signedIn()">Tasks</router-link>
        <router-link to="/add-worker" class="px-2 no-underline btn btn-info" v-if="signedIn()">Workers</router-link>
        <a href="#" @click.prevent="signOut" class=" px-2 no-underline btn btn-info" v-if="signedIn()">Sign out</a>
      </ul>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
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
<style>
 ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
}
</style>
