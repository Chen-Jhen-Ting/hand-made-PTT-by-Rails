Rails.application.routes.draw do
  root "pages#index" # get "/", to: "pages#index"   與root 寫法效果一樣
  get "/about" ,to: "pages#about"

  resources :boards do
    resources :posts, only: [:index, :new, :create]
    # only: 我們要做出路徑
    # 其實不做這些限制也沒差，只是路徑長出來會醜了點
    # 可以用 shado: true搞定這些事情
  end

  resources :posts, except: [:index, :new, :create]
  # except： 我們不要做出哪些 
end
