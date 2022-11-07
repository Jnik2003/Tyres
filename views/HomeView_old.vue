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
                @click.self="drawTimeBlock($event)"
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
                :min="inp.type == 'date' ? $store.getters.getCurrentDate : ''"
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

        <div class="btn-wrap">
          <hr />
          <button
            class="btn-confirm"
            @click="recToBase"
            :disabled="!allValidateTrue"
            ref="btn"
          >
            Записаться
          </button>
          <hr />
        </div>

        <modal-comp v-model:show="isModalVisible">
          <h3>{{ answers[responseFromServer] }}</h3>

          <div class="details" v-show="responseFromServer === '1'">
            <h4>Дата: {{ rec.date }}</h4>
            <h4>Время: {{ rec.time }}</h4>
          </div>
        </modal-comp>
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
      nowSelectedTime: '00:00'
    };
  },
  methods: {
    async recToBase() {
      this.$refs["btn"].setAttribute("disabled", "disabled");
      try {
        let response = await fetch("http://api/php/rec_data.php", {
        // let response = await fetch("http://test3.jnik.s53.hhos.ru/php/rec_data.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: JSON.stringify(this.rec),
        }); // serve
        let res = await response.text();
        this.responseFromServer = res;
        this.isModalVisible = true;
        this.resetInputs();
      } catch (e) {
        console.log("err");
        this.responseFromServer = "2";
        this.isModalVisible = true;
        this.$refs["btn"].removeAttribute("disabled");
      }
    },
    resetInputs() {
      this.inputs.forEach((item) => {
        item.valid = false;
        item.activated = false;
        item.value = "";
        if (item.type === "date") {
          item.value = this.rec.date;
          item.valid = true;
          item.activated = true;
        }
        this.bootTimes(this.rec.date);
      });
    },
    changeValue(name, val, inp, e) {
      this.rec[name] = val;
      inp.activated = true;
      let valid = inp.pattern.test(val);
      inp.valid = valid;
      if (inp.name === "time") {
        this.bootTimes(this.rec.date)    
      }

      if (inp.name === "date") {
        this.rec.time = "";
        this.$store.dispatch("resetTimeField");
        this.bootTimes(this.rec.date);
      }
    },
    // загрузка time из БД (т.е. уже занятое время)
    async bootTimes(d) {
      try {
        // let response = await fetch("http://test3.jnik.s53.hhos.ru/php/boot_times.php", { // production
        let response = await fetch("http://api/php/boot_times.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: "date=" + d,
        }); // serve
        this.noFreeTime = await response.json();
                
        this.$store.dispatch("updateTime")
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
    drawTimeBlock(e){
      // console.log(e.target.firstElementChild.value) 
      let time = e.target.firstElementChild.value
     this.nowSelectedTime = e.target.firstElementChild.value
     // e.target.classList.add('time-label-checked')
     let elem = document.querySelector(`input[value="${time}"]`)
     console.log(elem.parentNode)
     setTimeout(() => {
      elem.parentNode.classList.add('time-label-checked')
     },1200)
    
    }
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
.home{
  background-image: url('@/assets/img/bg.jpg');
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  padding-top: 20px;
}
.inputs {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
label {
  position: relative;
  width: 400px;
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
  // background-color: #6a1b9a;
  // color: white;
  .selected-time {
    width: 7px;
    height: 7px;
    // background-color: lime;
    border-radius: 50%;
    position: absolute;
    top: 15%;
    left: 15%;
  }
}

.time-label-checked{
  background-color: #6a1b9a;
  color: white;
}
.selected-time-checked{
  background-color: lime;
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
.btn-wrap{
  max-width: 400px;
  width: 100%;
  padding: 20px;
}
</style>
