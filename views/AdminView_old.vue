<template>
  <div class="container">
    <!-- <div class="dates">
      <input-date-comp v-model:date="dates.date1" @input="requestToDb" />
      <input-date-comp v-model:date="dates.date2" @input="requestToDb" />
    </div> -->
    <div class="dates">
      <label v-for="(inp, ind) in dates" :key="ind">
        <input-date-comp :date="inp" @upd="requestToDb(ind, $event)" />
      </label>
    </div>

    <div class="filters">
      <div class="inputs">
        <label for="select-field">Поиск по полю</label>
        <select id="select-field" v-model="selectedValue">
          <option :value="val" v-for="val in values" :key="val">
            {{ val }}
          </option>
        </select>
      </div>
      <div class="inputs">
        <label for="searchInp">Поиск</label>
        <input type="text" id="searchInp" :disabled="!selectedValue" :placeholder="selectedValue" v-model="searchValue">
      </div>

      <div class="inputs">
        <label for="select">Записей на стр.</label>
        <!-- <div class="select" id="select"> -->
          <select v-model="selectedOption" @change="page = 1" id="select">
            <option :value="opt" v-for="opt in options" :key="opt">
              {{ opt }}
            </option>
          </select>
        <!-- </div> -->
      </div>
    </div>

    <h3>Всего записей {{search.length }}</h3>
    <table
      border="1"
      width="100%"
      style="border-collapse: collapse"
      v-if="getData.length > 0"
    >
      <tr>
        <th>Id</th>
        <th>Дата</th>
        <th>Время</th>
        <th>Имя</th>
        <th>Телефон</th>
        <th>Email</th>
        <th>Удалить</th>
      </tr>

      <tr v-for="data in entriesOnPage" :key="data.id">
      <!-- <tr v-for="data in search" :key="data.id"> -->
        <td>{{ data.id }}</td>
        <td>{{ data.date }}</td>
        <td>{{ data.time }}</td>
        <td>{{ data.name }}</td>
        <td>{{ data.phone }}</td>
        <td>{{ data.email }}</td>
        <td><button class="btn btn-del" @click="del(data.id)">X</button></td>
      </tr>
    </table>

    <div class="pages">
      <div
        class="page"
        v-for="page in totalPages"
        :key="page"
        @click="changePage(page)"
        :class="{ active: page == this.page }"
      >
        {{ page }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "AdminView",
  data() {
    return {
      dates: {
        date1: new Date()
          .toLocaleString("lt", { timeZoneName: "short" })
          .slice(0, 10),
        date2: new Date()
          .toLocaleString("lt", { timeZoneName: "short" })
          .slice(0, 10),
      },
      options: [10, 20, 30],
      selectedOption: 10,
      page: 1,
      selectedValue: "",
      values: ["phone", "email"],
      searchValue: '',
    };
  },
  methods: {
    del(id) {
      this.$store.dispatch("delEntrie", id).then(() => {
        this.entriesOnPage.length == 0 ? (this.page = this.page - 1) : false;
      });
    },
    requestToDb(ind, newValue) {
      this.searchValue = ''
      this.dates[ind] = newValue;
      this.$store.dispatch("loadData", this.dates)
      this.page = 1;
    },
    changePage(page) {
      this.page = page;
    },
    // search(value){    
    //   // this.getData = this.getData.filter(item => item.phone == this.searchValue)
    //   // console.log(value, this.searchValue)
    //   let obj = {
    //     val: value,
    //     search: this.searchValue
    //   }
    //   // this.$store.dispatch('search',obj);
    // }
  },
  computed: {
    getData() {      
      return this.$store.getters.getDb;
    },
    totalPages() {
      return Math.ceil(this.search.length / this.selectedOption);
    },
    entriesOnPage() {
      let myData = this.$store.getters.getDb;
      // return myData.slice(
      return this.search.slice(
        (this.page - 1) * this.selectedOption,
        this.selectedOption * this.page
      );
    },
    search(){
      if(this.searchValue == ''){
        return this.getData
      }
      else{        
        if(this.selectedValue == 'phone'){
          return this.getData.filter(item => item['phone'].includes(this.searchValue))
        }
        else if(this.selectedValue == 'email'){
          return this.getData.filter(item => item['email'].includes(this.searchValue))
        }      
      }
      
    }
   
  },
  mounted() {
    this.$store.dispatch("loadData", this.dates);
  },
};
</script>

<style lang="scss" scoped>
.dates {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
  margin-bottom: 40px;
}
.btn-del {
  background-color: rgb(245, 187, 187);
  background-image: url("@/assets/svg/cancel.svg");
  background-size: contain;
  transition: 0.3s;
  width: 20px;
  height: 20px;
  border: none;
  border-radius: 50%;
  cursor: pointer;
}
.btn-del:hover {
  background-color: rgb(245, 150, 150);
  transform: rotate(15deg);
}
.pages {
  display: flex;
  gap: 10px;
  justify-content: center;
  align-items: center;
  margin-top: 20px;
}
.page {
  padding: 10px;
  border: 1px solid black;
  cursor: pointer;
}
.active {
  background-color: aquamarine;
}
.filters {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 40px;
}
.inputs{
  display: flex;
  flex-direction: column;
  gap: 5px;
}
</style>
