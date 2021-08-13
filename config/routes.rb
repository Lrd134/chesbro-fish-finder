Rails.application.routes.draw do
  resources :users, except: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', to: 'sessions#omniauth', via: [:get, :post]
  get '/signup', to: 'users#new'
  post '/users', to: 'sessions#create'
  get '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#destroy'
  root 'application#home'
end
