Rails.application.routes.draw do
  get 'instructions/new'
  root to: 'recipes#index'

  resources :recipes do
    resources :ingridients, :instructions, except: [:index, :show]
  end
end
