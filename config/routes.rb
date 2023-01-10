Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/exchange_token', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#index'
  patch '/dashboard', to: 'dashboard#update'

  get '/user/edit', to: 'user#edit'
  patch '/user', to: 'user#update'

  get '/activities', to: 'activities#index'

  get '/brugorithm', to: 'brugorithm#index'
end
