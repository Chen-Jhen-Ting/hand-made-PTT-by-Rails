

import { Controller } from "stimulus"
import ax from  'axios'
// import Rails from '@rails/ujs'
// 有了上面這行可以省掉很多工
export default class extends Controller{
  static targets = ["heart"]

  favorite () {
    let board_id = this.data.get('board')
  //     // 這是用 data-heart-board="<%= @board.id%>" 傳遞資料的拿法
    
  //   Rails.ajax({
  //     url: `/boards/${board_id}/favorite.json`,
  //     type: "post",
  //     success: (result) => {
  //       console.log(result.status)
  //       if (result['status'] == true ){
  //         this.heartTarget.classList.remove('far')
  //         this.heartTarget.classList.add('fas')
  //       }else{
  //         this.heartTarget.classList.add('far')
  //         this.heartTarget.classList.remove('fas')
  //       }
  //     },
  //     error:(err)=>{
  //       console.log(err)
  //     }
  //   })
  // }
    


      // 下方這些工作都被上方取代了  因為import {Rails} from '@rails/ujs' 這個套件搞定
    const token = document.querySelector("meta[name=csrf-token]").content
    ax.defaults.headers.common['X-CSRF-Token']= token

    ax.post(`/boards/${board_id}/favorite.json`)
      .then( (result)=>{
        console.log(result)
        if (result.data['status'] == true ){
          this.heartTarget.classList.remove('far')
          this.heartTarget.classList.add('fas')
        }else{
          this.heartTarget.classList.add('far')
          this.heartTarget.classList.remove('fas')
        }
      })
      .catch(function(err){
        console.log(err)
      })
    }

    removeauthor(){
      var event = new CustomEvent("authorBye~", {
        detail: {
          hazcheeseburger: true
        }
      });
      window.dispatchEvent(event);
    }
}



