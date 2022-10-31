import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

const app = createApp(App);
app.use(store).use(router).mount("#app");

if (!Object.prototype.length) {
    Object.defineProperty(Object.prototype, 'length', {
        get: function() {
            return Object.keys(this).length
        }
    })
}
