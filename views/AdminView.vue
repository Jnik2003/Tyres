<template>
  <div class="admin-page">
  <div class="container">
   
    <div class="dates">
      <label v-for="(inp, ind) in dates" :key="ind" class="label-dates">
        <input-date-comp :date="inp" @upd="updDate(ind, $event)" />
       
      </label>
      <div class="validate" :class="[isValidDates ? 'green' : 'red']"></div>
    </div>

    <div class="filters">
      <div class="inputs">
        <label for="select-field">Поиск по полю</label>
        <select id="select-field" v-model="selectedValue">
          <option :value="val.value" v-for="val in values" :key="val">
            {{ val.text }}
          </option>
        </select>
      </div>
      <div class="inputs">
        <label for="searchInp">Поиск</label>
        <input
          type="text"
          id="searchInp"
          :disabled="!selectedValue"          
          v-model="searchValue"
          @input="page = 1"
        />
      </div>

      <div class="inputs">
        <label for="select">Записей на стр.</label>
        <select v-model="selectedOption" id="select" @change="page = 1">
          <option :value="opt" v-for="opt in options" :key="opt">
            {{ opt }}
          </option>
        </select>
      </div>
    </div>

    <h3 v-if="allEntriesLength > 0">Всего записей {{ allEntriesLength }}</h3>
    <h3 v-else>На эти даты никто не записан</h3>
    <table
      border="1"
      width="100%"
      style="border-collapse: collapse"
      v-if="allEntriesLength > 0"
    >
      <tr class="tbl-header">
        <th>Id</th>
        <th>Дата</th>
        <th>Время</th>
        <th>Имя</th>
        <th>Телефон</th>
        <th>Email</th>
        <th>Удалить</th>
      </tr>

      <tr v-for="data in entriesOnPage" :key="data.id">     
        <td>{{ data.id }}</td>
        <td>{{ data.date }}</td>
        <td>{{ data.time }}</td>
        <td>{{ data.name }}</td>
        <td>{{ data.phone }}</td>
        <td>{{ data.email }}</td>
        <td><button class="btn btn-del" @click="del(data.id)"></button></td>
      </tr>
    </table>

    <div class="pages">
      <div
        class="page"
        v-for="p in totalPages"
        :key="p"
        @click="changePage(p)"
        :class="{ active: p == this.page }"
        v-show="allEntriesLength > 0"
      >
        {{ p }}
      </div>
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
      totalPages: '',
      selectedValue: 'phone',
      values: [
        { text: "Телефон", value: "phone" },
        { text: "Email", value: "email" },
      ],
      searchValue: "",
      isValidDates: true,
    };
  },
  methods: {
    updDate(ind, e) {
      this.dates[ind] = e;
    },
    del(id) {
      this.$store.dispatch("delEntrie", id).then(() => {
        this.goToPreviousPage()
      });
    },
    changePage(page) {
      this.page = page;
    },
    goToPreviousPage(){
      this.entriesOnPage.length == 0 ? (this.page = this.page - 1) : false;
    },
        
   
  },
  computed: {
    loadData() {      
      
      if(this.dates.date1 > this.dates.date2 || this.dates.date2 < this.dates.date1){        
        console.log('err')
        this.isValidDates = false;       
        this.$store.dispatch("loadData", this.dates);
        return false;
      }      
      else{
        console.log('loadData')
        this.isValidDates = true;
        this.$store.dispatch("loadData", this.dates);
      }
     
      
     
    }, 
    getData() {   
      this.loadData
      return this.$store.getters.getDb;
    },
    searchAndGetData() {  
      if(this.getData){
        return this.getData.filter(item => item[this.selectedValue].includes(this.searchValue)) 
      }      
    },
    entriesOnPage() {  
      this.totalPages = Math.ceil(this.searchAndGetData.length / this.selectedOption);   
      return this.searchAndGetData.slice(
        (this.page - 1) * this.selectedOption,
        this.selectedOption * this.page
      )
    },
    allEntriesLength() {
      if(this.searchAndGetData){
        return this.searchAndGetData.length
      }      
    },
    
  },
  mounted() {
    // this.$store.dispatch("loadData", this.dates); 
  },
  watch:{
  
  }
};
</script>

<style lang="scss" scoped>
.container{
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
.admin-page{
  padding-top: 20px;
}
.dates {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
  margin-bottom: 40px;
  position: relative;
  max-width: 550px;
  width: 100%;
}
.validate{
  top: 0;
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
  background-color: #baee7e;
}
.filters {
  display: flex;
  justify-content: space-between;
  align-items:flex-start;
  gap: 40px;
}
.inputs {
  display: flex;
  flex-direction: column;
  gap: 5px;
}
tr:nth-child(even) {
  background: silver;
}
.tbl-header{
  background-color: #DCEDC8;
  height: 40px;
}
.label-dates{
  position: relative;
}
.valid-dates{

}

</style>
