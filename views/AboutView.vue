<template>
  <div class="about-page">
    <div class="container">
      <div class="about" v-for="(part, ind) in about" :key="part">
        <div class="about__title  flex">
          <h4> {{ part.title }} </h4>
        </div>

        <transition name="anim">
          <div class="descr" v-show="part.invisible">
            <div v-for="t, ind in part.text" :key="ind">
              <p>{{t}}</p>
            </div>
          
          </div>
        </transition>
        <div
          class="arrow"
          @click="toggle(ind)"
          :class="[part.invisible == false ? 'arrow_down' : 'arrow_up']"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>


export default {
  name: "AboutView",
  data() {
    return {
      about: {
        homepage: {
          title: "О главной странице",         
          invisible: true,
          text: maintext,        
        },
        admin: {
          title: "Об админке",
          invisible: false,
          text: admintext,
        },
        additional:{
          title: "Дополнительно",
          invisible: false,
          text: other,
        }
      },
    };
  },
  methods: {
    toggle(val) {
      this.about[val].invisible = !this.about[val].invisible;
    },
  },
};

const maintext = {
  t1: `• На главной странице представлена форма записи на шиномонтаж`,
  t2: `• Для разработки приложения использовался Vue 3, PHP, база данных MySql`,
  t3: `• Календарь позволяет выбрать дату, на которую нужно записаться. Выбрать дату меньшую, чем текущая - нельзя`,
  t4: `• Выводится информация о количестве свободных мест для записи на выбранную дату`,
  t5: `• В поле выбора времени записи из БД выводятся слоты для записи. Слоты могут быть активные и неактивные, если на это время кто-то записан. Выбор времени записи возможен только на незанятые слоты. Во время выбора времени каждый раз происходит проверка незанятости слотов. Если в процессе выбора времени другой пользователь записался на какое-нибудь время, этот слот будет помечен как неактивный для всех. Если время записи не выбрано, этот пункт не проходит валидацию (иконка в правом верхнем углу)`,
  t6: `• Далее следуют три однотипных поля для ввода информации об имени, телефоне и email пользователя, которые валидируются каждый по своему. Об успехе или не успехе валидации говорит иконка в правом верхнем углу`,
  t7: `• Кнопка "записаться" неактивна, пока не пройдена валидация всех полей. Также кнопка становится неактивной сразу после нажатия, для предотвращения двойного клика, а далее, если запись в БД произведена, снова становится неактивной. В случае ошибки записи в БД, кнопка становится активной, текст в полях ввода сохпаняется. В случае успешной отправки данных, пользователь получает письмо на почту с напоминанием о дате и времени записи`,
  t8: `• После отправки данных на сервер появляется модально окно. В случае успешной записи в БД в окне выводится информация о дате и времени записи. В случае ошибки записи выводится информация о том, что произошла ошибка и необходимо повторить попытку. Также, третий вариант информации в модальном окне - когда кто-то успел записаться на ту же дату, которую выбрал пользователь. В этом случае, информация в БД не записывается, необходимо выбрать друго время`,
}
const admintext = {
  t1: `• На странице "Админка" представлена форма вывода записей на шиномонтаж`,
  t2: `• Есть возможность выбрать диапазон дат для вывода информации из БД. Если диапазоны пересекаютcя, то валидация не проходит, о чем сигнализирует иконка в правом верхнем углу`,
  t3: `• После вывода информации в таблицу отображается общее количество записей за этот диапазон дат. Таблица отсортирована по времени и дате на стороне сервера. Реализована пагинация`,
  t4: `• По таблице можно делать поиск по полям "телефон" и "email"`,
  t5: `• Есть возможность вывода определенного количества строк таблицы - 10, 20, 30`,
}
const other = {
  t1: `• Можно тестировать, записываться, удалять записи`,
}
</script>

<style lang="scss" scoped>
p{   
    margin: 0;
}
.flex{
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
.about-page {
  padding-top: 20px;
}
.about {
  background-color: antiquewhite;
  position: relative;
}
.about__title {
  height: 50px;  
}
.descr {
  background-color: aliceblue;
text-align: left;
padding: 20px;

}
.arrow {
  width: 50px;
  height: 50px;

  background-size: contain;
  transition: 0.3s;
  position: absolute;
  top: 0;
  right: 0;
  cursor: pointer;
}
.arrow_down {
  background-image: url("@/assets/svg/arrow_down.svg");
}
.arrow_up {
  background-image: url("@/assets/svg/arrow_up.svg");
}
.anim-enter-active {
  transition: all 0.3s ease-out;
}
.anim-leave-active {
  transition: all 0.3s ease-in;
}

.anim-enter-from,
.anim-leave-to {
  transform: translateY(-50px);
  opacity: 0;
}


</style>
