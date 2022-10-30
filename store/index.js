import { createStore } from "vuex";

export default createStore({
  state: {},
  getters: {},
  mutations: {},
  actions: {
    async connectToBd({ commit }) {     
      try {
        // let response = await fetch("http://php/test.php");// production
        let response = await fetch("http://api/php/test.php");// serve
        let products = await response.json();
        console.log(products);
        // commit("setItems", products);
      } catch (e) {
        console.log("err");
      }
    },
  },
  modules: {},
});
