<template>
  <div id="app">
    <Header />
    <br/>
    <router-view/>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'

export default {
  name: 'App',
  components: {
    'Header': Header

  }
}
</script>
