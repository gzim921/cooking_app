Rails.application.routes.draw do
  root to: 'recipes#index'

  resources :recipes do
    resources :ingridients, except: [:index, :show]
  end
end
