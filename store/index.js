import { createStore } from "vuex";

export default createStore({
  state: {
    time: options(),
    fields: inputs(),
    db: '',
  },
  getters: {
    getTime(state){
      return state.time
    },
    getFields(state){
      return state.fields
    },
    getDb(state){
      return state.db
    }
  },
  mutations: {
    updateTime(state){
      state.time = options()
    },
    setDb(state, entries){
      // state.db.push(entries)
      state.db = entries
    },
    clearDb(state){
      state.db = ''
    },
    delEntrie(state, id){
      console.log('del')
      state.db = state.db.filter(item => item.id != id)      
    },
    resetTimeField(state){
      state.fields.forEach(item => {
        if(item.name === 'time'){
          item.activated = false
          item.valid = false
          item.value = ''
        }
      })      
    }

  },
  actions: {
    
    async loadData({ commit }, dates) {  
      commit("clearDb")   
      try {
        // let response = await fetch("http://php/get_data.php");// production
        let response = await fetch("http://api/php/get_data.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: JSON.stringify(dates),
        }); // serve
        let entries = await response.text();
        // console.log(entries);
        entries = JSON.parse(entries)
        commit("setDb", entries);
      } catch (e) {
        console.log("err");
      }
    },
    updateTime({commit}){
      commit('updateTime')
    },
    async delEntrie({commit}, id){      
      try {
        // let response = await fetch("http://php/get_data.php");// production
        let response = await fetch("http://api/php/del_data.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },          
          body: 'id=' + id,
        }); // serve       
        commit('delEntrie', id)
      } catch (e) {
        console.log("err");
      }
    },  
    resetTimeField({commit}){
      commit('resetTimeField')
    }
   
  },
 
  modules: {},
});

function options(){
  return {
    '09:00':{
      free: true,
    },
    '09:30':{
      free: true,
    },
    '10:00':{
      free: true,
    },
    '10:30':{
      free: true,
    },
    '11:00':{
      free: true,
    },
    '11:30':{
      free: true,
    },
    '12:00':{
      free: true,
    },
    '12:30':{
      free: true,
    },
    '13:00':{
      free: true,
    },
    '13:30':{
      free: true,
    },
    '14:00':{
      free: true,
    },
    '14:30':{
      free: true,
    },
    '15:00':{
      free: true,
    },
    '15:30':{
      free: true,
    },
    '16:00':{
      free: true,
    },
    '16:30':{
      free: true,
    },
    '17:00':{
      free: true,
    },
    '17:30':{
      free: true,
    },
}

}

function inputs(){
  return [
    {
      label: 'Выберите дату',
      name: 'date',
      type: 'date',
      // value: new Date().toISOString().slice(0, 10),
      value: new Date().toLocaleString( 'lt', { timeZoneName: 'short' } ).slice(0, 10),
      pattern: /.+/,
      valid: true,
      activated: true
    },
    {
      label: 'Выберите время',
      name: 'time',
      type: 'radio',
      value: '',
      pattern: /.+/,
      valid: false,
      activated: false
    },
    {
      label: 'Имя',
      name: 'name',
      type: 'text',
      value: '',
      pattern: /^[а-яё a-z]{3,30}$/iu,
      valid: false,
      activated: false
    },
    {
      label: 'Телефон',
      name: 'phone',
      type: 'text',
      value: '',
      pattern: /^[\d\+][\d\(\)\ -]{4,14}\d$/,
      valid: false,
      activated: false
    },
    {
      label: 'Email',
      name: 'email',
      type: 'email',
      value: '',
      pattern: /(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])/,
      valid: false,
      activated: false
    }
    

  ]
}
