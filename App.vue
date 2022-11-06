<template>
  <div class="nav-bar">
    <div class="logo">
      <router-link class="nav-link" to="/">
        <img src="@/assets/img/wheel.png" alt="Wheel" />
      </router-link>
      
      <h4>Шинка</h4>
    </div>
    <nav>
      <router-link class="nav-link" to="/">Запись онлайн</router-link>
      <router-link class="nav-link" to="/admin">Админка</router-link>
      <router-link class="nav-link" :to="{ name: 'about' }"
        >О проекте</router-link
      >
    </nav>
  </div>

  <router-view />
</template>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
.nav-bar {
  background-color: antiquewhite;
  display: flex;
  justify-content: space-around;
  align-items: center;
  margin-bottom: 20px;
  height: 60px;
}
.logo {
  width: 25%;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
}
.logo > a > img {
  width: 50px;
  height: 50px;
}
.logo > h4 {
  text-transform: uppercase;
}

nav {
  padding: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 40px;

  width: 100%;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
.container {
  max-width: 1024px;
  width: 100%;
  margin: 0 auto;
}
button {
  cursor: pointer;
}
.wrap {
  width: 400px;
  margin: 0 auto;
}
.btn-confirm {
  width: 200px;
  height: 40px;
  border: none;
  background-color: #ff6f00;
  font-size: 16px;
  text-transform: uppercase;
  letter-spacing: 1px;
  color: white;
  transition: 0.3s;
}
.btn-confirm:hover {
  background-color: #689f38;
}
.btn-confirm:disabled {
  background-color: grey;
  opacity: 0.5;
  cursor: initial;
}
input[type="text"],
input[type="email"] {
  width: 200px;
  height: 20px;
  font-size: 16px;
  // padding: 3px 5px;
}
#select,
#select-field {
  width: 200px;
  // height: 20px;
  font-size: 16px;
  padding: 3px 5px;
}
input[type="date"] {
  width: 200px;
  height: 30px;
  font-size: 20px;
}
.nav-link {
  text-decoration: none;
}
.validate {
  width: 20px;
  height: 20px;
  position: absolute;
  top: 10px;
  right: 3%;
  background-color: antiquewhite;
  border-radius: 50%;
  background-image: url("@/assets/svg/help.svg");
  background-size: contain;
  transition: 0.3s;
}
.red {
  background-color: lightcoral;
  background-image: url("@/assets/svg/cancel.svg");
  background-size: contain;
  transition: 0.3s;
}
.green {
  background-color: lightgreen;
  background-image: url("@/assets/svg/check.svg");
  background-size: contain;
  transition: 0.3s;
}
</style>
