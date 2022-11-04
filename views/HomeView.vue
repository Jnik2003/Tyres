<template>
  <div class="home">
    <div class="container">
      <div class="wrap">
        <div class="text">
          <h3>На эту дату свободных слотов {{ count > 0 ? count : "нет" }}</h3>
        </div>

        <div class="inputs">
          <label v-for="(inp, ind) in inputs" :key="ind" class="label">
            {{ inp.label }}
            <!-- {{inp}} -->
            <div class="times" v-if="inp.name == 'time'">
              <label
                v-for="(time, name) in times"
                :key="time"
                class="label-radio"
              >
                <input
                  type="radio"
                  name="time"
                  :disabled="!time.free"
                  v-model="inp.value"
                  :value="name"
                  @input="changeValue(inp.name, name, inp)"
                />
                {{ name }}
                <div class="selected-time"></div>
              </label>
            </div>

            <div v-else>
              <input
                :type="inp.type"
                v-model.trim="inp.value"
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
        <button class="btn-confirm" @click="recToBase" :disabled="!allValidateTrue">
          Записаться
        </button>
        <hr />
        {{ rec }}

        <modal-comp v-model:show="isModalVisible">
          <h3>{{ answers[responseFromServer] }}</h3>

          <div class="details" v-show="responseFromServer === '1'">
            <h4>Дата: {{ rec.date }}</h4>
            <h4>Время: {{ rec.time }}</h4>
          </div>
        </modal-comp>

        <hr />
      </div>
    </div>
  </div>
</template>

<script>
import ModalComp from "@/components/ModalComp.vue";

export default {
  name: "HomeView",
  data() {
    return {
      rec: {
        // date: new Date().toISOString().slice(0, 10),
        // date: this.inputs[0].value,
        time: "",
        name: "",
        phone: "",
        email: "",
      },
      answers: {
        0: "",
        1: "Вы записаны",
        2: "Ошибка записи, повторите еще раз",
        3: "Кто-то записался на это время раньше Вас. Выберите другое время",
      },
      noFreeTime: [],
      times: this.$store.getters.getTime,
      isModalVisible: false,
      responseFromServer: "0",
      // isSuccessRec: false,
    };
  },
  methods: {
    async recToBase() {
      // console.log(this.rec);
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
        // console.log(res);
        this.responseFromServer = res;
        this.isModalVisible = true;
        this.resetInputs();
      } catch (e) {
        console.log("err");
        this.responseFromServer = "2";
        this.isModalVisible = true;
      }
    },
    resetInputs() {
      this.inputs.forEach((item) => {
        item.valid = false;
        item.activated = false;
        item.value = "";
        // item.type === 'date' ? item.value = this.rec.date : false
        // item.type === 'date' ? item.valid = true : false
        // item.type === 'date' ? item.activated = true : false
        if (item.type === "date") {
          item.value = this.rec.date;
          item.valid = true;
          item.activated = true;
        }
        this.bootTimes(this.rec.date);
      });
    },
    changeValue(name, val, inp) {
      console.log(name);
      console.log(inp);
      console.log(val)

    
      this.rec[name] = val;
      inp.activated = true;
      let valid = inp.pattern.test(val);
      inp.valid = valid;

      if (inp.name === "date") {
        this.rec.time = "";    
        this.$store.dispatch('resetTimeField')
        this.bootTimes(this.rec.date);
      }
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
    count() {
      return this.times.length - this.noFreeTime.length;
    },
    allValidateTrue() {
      return this.inputs.every((item) => {
        return item.valid == true;
      });
    },
  },
  mounted() {
    this.inputs.forEach((item) => {
      this.rec[item.name] = item.value;
    });
    this.bootTimes(this.rec.date);
    this.$store.dispatch("loadData", {
      date1: new Date()
        .toLocaleString("lt", { timeZoneName: "short" })
        .slice(0, 10),
      date2: new Date()
        .toLocaleString("lt", { timeZoneName: "short" })
        .slice(0, 10),
    });
  },
  components: { ModalComp },
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
input[type="date"] {
  width: 200px;
  height: 30px;
  font-size: 20px;
}
.times {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  align-items: center;
}
.label {
  display: flex;
  flex-direction: column;
  padding: 20px 20px;
  background-color: #dcedc8;
  gap: 20px;
}
.label-radio {
  width: 50px;
  background-color: #d1c4e9;
  cursor: pointer;
  transition: 0.3s;
  border-radius: 0.3rem;
}
.label-radio:hover {
  background-color: #ce93d8;
}

.label-radio:has(> input[type="radio"]:checked) {
  background-color: #6a1b9a;
  color: white;
  .selected-time {
    width: 7px;
    height: 7px;
    background-color: lime;
    border-radius: 50%;
    position: absolute;
    top: 15%;
    left: 15%;
  }
}
input[type="radio"] {
  opacity: 0;
  position: relative;
  pointer-events: none;
}
.text {
  width: 100%;
  padding: 0 20px;
  padding: 20px 20px;
  background-color: #aed581;
}
h3 {
  margin: 0;
}
.label-radio:has(> input[type="radio"]:disabled) {
  background-color: #eceff1;
  cursor: initial;
  color: black;
  .selected-time {
    background-color: transparent;
  }
}
input[type='text'],
input[type='email']{
  width: 200px;
  height: 20px;
  font-size: 16px;
}
.btn-confirm{
  width: 200px;
  height: 40px;
  border: none;
  background-color: #FF6F00;
  font-size: 16px;
  text-transform: uppercase;
  letter-spacing: 1px;
  color: white;
  transition: .3s;
}
.btn-confirm:hover{
  background-color: #689F38;
}
.btn-confirm:disabled{
  background-color: grey;
  opacity: .5;
  cursor: initial;
}
</style>
