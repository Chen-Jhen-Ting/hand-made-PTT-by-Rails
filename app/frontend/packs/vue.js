import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from 'vue/components/app.vue'
// 當app.vue搬家，要記得改路徑


Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  let el =document.querySelector('#app');
  if (el){
    new Vue({
      el: el,
      components: { App }
      // 這個app是上方import的App 是從 app.vue檔案來的
    })
  }
})
