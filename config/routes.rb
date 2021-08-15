Rails.application.routes.draw do
  resources :fish, only: [ :new ]
  scope '/fish' do
    get '/', to: 'fish#index', as: 'fish_index'
    get '/:fish_slug/edit', to: 'fish#edit', as: 'edit_fish'
    post '/', to: 'fish#create'
    post '/:fish_slug', to: 'fish#update'
    get '/categories', to: 'categories#index', as: 'categories'
    get '/:cat_slug', to: 'categories#show', as: 'category'
    get '/:fish_slug/:cat_slug', to: 'fish#show', as: 'fish'
  end
  resources :users, except: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  match '/auth/:provider/callback', to: 'sessions#omniauth', via: [:get, :post]
  get '/signup', to: 'users#new'
  post '/users', to: 'sessions#create'
  get '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#destroy'
  root 'application#home'

end
