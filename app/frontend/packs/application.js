

require("@rails/ujs").start()
// 這邊會去捕捉我們打算模擬的任何動作， ex delete  deta-method 之類的，如果他壞了，就只會
// 接受瀏覽器的 post get，模擬的動作都會失效


require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")




// (e.g <%= image_pack_tag 'rails.png' %>)
// app/javascript/images/rails.png 要這樣放檔案，自己建立image file

// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

console.log('hello')