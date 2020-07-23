Rails.application.routes.draw do
  root "pages#index"
  # get "/", to: "pages#index"   與root 寫法效果一樣
  get "/about" ,to: "pages#about"
end
