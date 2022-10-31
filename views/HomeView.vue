<template>
  <div class="home">
    <div class="container">
      <h3>На эту дату свободных слотов {{count}}</h3>
      
      <div class="inputs">
        <label v-for="(inp, ind) in inputs" :key="ind">
          {{ inp.label }}
          <!-- {{inp}} -->
          <div class="times" v-if="inp.name == 'time'">
            <label v-for="(time, name) in times" :key="time">
              <input
                type="radio"
                name="time"
                :disabled="!time.free"
                v-model="inp.value"
                :value="name"
                @input="changeValue(inp.name, name, inp)"
              />
              {{ name }}
            </label>
          </div>          

          <div v-else>
            <input
              :type="inp.type"
              v-model="inp.value"
              @input="changeValue(inp.name, inp.value, inp)"
            />
          </div>
          <div
            class="validate"
            :class="{ red: inp.activated, green: inp.valid }"
          ></div>
        </label>
      </div>

      <hr />
      <button @click="recToBase" :disabled="!allValidateTrue()">
        Записаться
      </button>

      {{rec}}

      <hr />
    </div>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: "HomeView",
  data() {
    return {
      rec: {
        date: new Date().toISOString().slice(0, 10),
        time: "",
        name: "",
        phone: "",
        email: "",
      },
      noFreeTime: [],
      times: this.$store.getters.getTime,
      isModalVisible: false,
      responseFromServer: '',
    };
  },
  methods: {
    async recToBase() {
      console.log(this.rec);     
      try {
        // let response = await fetch("http://php/rec_data.php");// production
        let response = await fetch("http://api/php/rec_data.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: JSON.stringify(this.rec),
        }); // serve
        let res = await response.text();
        console.log(res);
        this.responseFromServer = res
        
        this.resetInputs()
        
        // this.isRec = true
        // commit("setItems", products);
      } catch (e) {
        console.log("err");
      }
    },
    resetInputs(){
      this.inputs.forEach(item => {
        item.valid = false
        item.activated = false
        item.value = ''
        item.type === 'date' ? item.value = this.rec.date : false
        item.type === 'date' ? item.valid = true : false
        item.type === 'date' ? item.activated = true : false
        this.bootTimes(this.rec.date)
      })
    },
    changeValue(name, val, inp) {
      this.rec[name] = val;
      inp.activated = true;
      let valid = inp.pattern.test(val);
      inp.valid = valid;

      if (inp.name === "date") {
        this.bootTimes(this.rec.date);
      }
    },
    allValidateTrue() {
      return this.inputs.every((item) => {
        return item.valid == true;
      });
    },
    async bootTimes(d) {
      try {
        // let response = await fetch("http://php/test.php");// production
        let response = await fetch("http://api/php/boot_times.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: "date=" + d,
        }); // serve
        this.noFreeTime = await response.json();
        this.$store.dispatch("updateTime");
        this.times = this.$store.getters.getTime;

        this.noFreeTime.forEach((item) => {
          if (this.times[item.time].free) {
            this.times[item.time].free = false;
          }
        });
      } catch (e) {
        console.log("err boot");
      }
    },
  },
  computed: {
    inputs() {
      return this.$store.getters.getFields;
    },
    count(){
    
      return this.times.length - this.noFreeTime.length
    },
  },
  mounted() {
    // this.$store.dispatch("loadData");
    this.bootTimes(this.rec.date);
  },
  components: {},
};
</script>
<style lang="scss" scoped>
.inputs {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
label {
  position: relative;
  width: 400px;
}
.validate {
  width: 20px;
  height: 20px;
  position: absolute;
  top: 0;
  right: 0;
  background-color: antiquewhite;
  border-radius: 50%;
}
.red {
  background-color: red;
}
.green {
  background-color: lightgreen;
}
</style>
