<template>
  <div class="hello container shadow-lg p-5">
    <h1>{{ msg }}</h1>
    <p>It is created with ruby on rails in backend api and vuejs as frontend</p>
    <p>For Styling Bootstrap and tailwindcss used</p>
    <p>Admin login need to create task ,assets,and worker</p>

 </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data () {
    return {
      msg: 'Welcome to HouseKeeping App.'
    }
  }
}
</script>
