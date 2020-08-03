Rails.application.routes.draw do
  root "pages#index" # get "/", to: "pages#index"   與root 寫法效果一樣
  get "/about" ,to: "pages#about"

  resources :boards do
    resources :posts, only: [:index, :new, :create]
    # only: 我們要做出路徑
    # 其實不做這些限制也沒差，只是路徑長出來會醜了點
    # 可以用 shallow: true搞定這些事情
  end

  resources :posts, except: [:index, :new, :create]
  # except： 我們不要做出哪些 

  resources :users, only: [ :create ] do
    # member do   用這個路徑會包含id  我們不要
    #   get :profile
    # end
    collection do
      get :sign_up 
      get :edit
      patch :update
      get :sign_in 
      post :login
      delete :sign_out
      # get post delete 都可以，這些都是假的，但是logout會有去除 session 的行為，用delete比較符合 restful精神
    end
    # 用這個路徑不會有 ID  需要這個
  end
end
