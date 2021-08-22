Rails.application.routes.draw do
  root 'application#home'

  resources :fish, only: [ :new ]
  scope '/fish' do
    scope '/:fish_slug' do
      scope '/:cat_slug' do
        get '/edit', to: 'fish#edit', as: 'edit_fish'
        get '/', to: 'fish#show', as: 'fish'
        post '/delete', to: 'fish#destroy', as: 'delete_fish'
        resources :comments
      end
    end
    get '/', to: 'fish#index', as: 'fish_index'
    post '/', to: 'fish#create'
    patch '/:id/:cat_slug', to: 'fish#update'
    #get '/:fish_slug/:cat_slug/edit', to: 'fish#edit', as: 'edit_fish'

    get '/categories', to: 'categories#index', as: 'categories'
    get '/:cat_slug', to: 'categories#show', as: 'category'
    #get '/:fish_slug/:cat_slug', to: 'fish#show', as: 'fish'
  end
  resources :users, except: [:create, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/signup', to: 'users#new'
  post '/users', to: 'sessions#create'
  get '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#destroy'
  get '/user/username', to: 'users#username', as 'create_username'
  match '/auth/:provider/callback', to: 'sessions#omniauth', via: [:get, :post]


end
