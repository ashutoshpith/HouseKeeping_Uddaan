<template>
  <div class="max-w-md m-auto py-10 container shadow-lg p-5 bg-dark rounded">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4 text-white">Add a new Assets</h3>
    <form action="" @submit.prevent="addProduct">
      <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Type an arist name"
          v-model="newProduct.name" />
      </div>
      <br>
      <input type="submit" value="Add product" class="btn btn-lg btn-warning" />
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="product in products" :key="product.id" :product="product">

        <div class="flex items-center justify-between flex-wrap text-white">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music product</title><path d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path></svg>
            {{ product.name }}
          </p>

          <button class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
          @click.prevent="editProduct(product)">Edit</button>

          <button class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
         @click.prevent="removeProduct(product)">Delete</button>
        </div>

        <div v-if="product == editedProduct">
          <form action="" @submit.prevent="updateProduct(product)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="product.name" />
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
  name: 'products',
  data () {
    return {
      products: [],
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
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addProduct () {
      const value = this.newProduct
      if (!value) {
        return
      }
      this.$http.secured.post('/api/v1/products/', { product: { name: this.newProduct.name } })

        .then(response => {
          this.products.push(response.data)
          this.newProduct = ''
        })
        .catch(error => this.setError(error, 'Cannot create product'))
    },
    removeProduct (product) {
      this.$http.secured.delete(`/api/v1/products/${product.id}`)
        .then(response => {
          this.products.splice(this.products.indexOf(product), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete product'))
    },
    editProduct (product) {
      this.editedproduct = product
    },
    updateProduct (product) {
      this.editedProduct = ''
      this.$http.secured.patch(`/api/v1/products/${product.id}`, { product: { title: product.name } })
        .catch(error => this.setError(error, 'Cannot update product'))
    }
  }
}
</script>
