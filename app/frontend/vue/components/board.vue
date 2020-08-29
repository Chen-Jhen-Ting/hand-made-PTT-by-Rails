<template>
    <div>
        <ul>
            <li v-for="board in boards" :key="board.id" >{{ board.title }} 
                <a :href="'/boards/'+board.id" data-confirm="確定嗎？" data-method='delete'>
                    刪除
                </a>
            </li>
        </ul>
    </div>
</template>

<script>
import R from "@rails/ujs"
export default {
  data: function () {
    return {
        boards: [],
    }
  },
  beforeCreate: function(){
    // let that = this  
    R.ajax({
          url: '/api/v2/boards.json',
          type: "get",
        //   不要用function(){} 因為這樣會有自己的this
          success: (data) => {
            this.boards = data
            // data.map( function(d){
            //     return d.title
            
        },
          error: function(err){}
      })
  }
}
</script>

<style scoped>

</style>
