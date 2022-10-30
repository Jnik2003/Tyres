import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

// store.dispatch("load").then(() => {
//   const app = createApp(App);
//   app.use(store).use(router).mount("#app");
// });
const app = createApp(App);
  app.use(store).use(router).mount("#app");