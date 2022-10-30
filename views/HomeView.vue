<template>
  
  <div class="home">
    
    <img alt="Vue logo" src="../assets/logo.png">
   
  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'HomeView',
  mounted(){
    this.$store.dispatch('connectToBd')
  },
  components: {   
  }
}
</script>
