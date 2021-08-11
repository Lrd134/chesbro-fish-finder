Rails.application.routes.draw do
  resources :users, except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', to: 'session#create', via: [:get, :post]
  get '/signup', to: 'users#new'
  root 'application#home'
end
