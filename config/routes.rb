Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  get "/exchange_token", to: 'sessions#create'
  get "/dashboard", to: "dashboard#index"
  patch "/dashboard", to: "dashboard#update"
  get "/user/edit", to: "user#edit"
  patch "/user/edit", to: "user#edit"
end
