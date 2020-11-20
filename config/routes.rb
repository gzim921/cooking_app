Rails.application.routes.draw do
  root to: 'recipes#index'

  resources :recipes do
    resources :ingridients, :instructions, except: [:index, :show]
  end

  get '/signup', to: 'users#new', as: :new_user
  resources :users, except: [:index, :new, :destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
end
