<template>
  <div class="container">
    <div class="dates">
      <input-date-comp v-model:date="dates.date1" @input="requestToDb" />
      <input-date-comp v-model:date="dates.date2" @input="requestToDb" />
    </div>

    <div class="inpits">
      <label for="select">Записей на стр.</label>
      <div class="select" id="select">
        <select v-model="selectedOption" @change="page = 1">
          <option :value="opt" v-for="opt in options" :key="opt">
            {{ opt }}
          </option>
        </select>
      </div>
    </div>

    <h3>Всего записей {{ getData.length }}</h3>
    <table border="1" width="100%" style="border-collapse: collapse">
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
      >
        {{ page }}
      </div>
    </div>
    Текущая{{ page }}
    <br>
    {{totalPages}}
    <br>
    On last page {{entriesOnPage.length}}
  </div>
</template>

<script>
export default {
  name: "AdminView",
  data() {
    return {
      dates: {
        date1: new Date().toISOString().slice(0, 10),
        date2: new Date().toISOString().slice(0, 10),
      },
      options: [5, 15, 30],
      selectedOption: 5,
      page: 1,
    };
  },
  methods: {
    del(id) {
      this.$store.dispatch("delEntrie", id).then(()=>{
        this.entriesOnPage.length == 0 ? this.page = this.page - 1 : false
      })
     
      // this.page = this.page - 1
      
    },
    requestToDb() {
      this.$store.dispatch("loadData", this.dates);
    },
    changePage(page) {
      this.page = page;
    },
  },
  computed: {
    getData() {
      return this.$store.getters.getDb;
    },
    totalPages() {
      return Math.ceil(this.getData.length / this.selectedOption);
    },
    entriesOnPage() {
      let myData = this.$store.getters.getDb;
      return myData.slice(
        (this.page - 1) * this.selectedOption,
        this.selectedOption * this.page
      );
    },    
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
}
</style>
