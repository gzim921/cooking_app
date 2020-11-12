Rails.application.routes.draw do

  resources :recipes do
    resources :ingridients, :instructions, except: [:index, :show]
  end

  get '/signup', to: 'users#new', as: :new_user
  resources :users, except: [:index, :new, :destroy]
end
