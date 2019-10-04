Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips, only: [:new, :show, :create, :update ] do
    resources :trip_items, only: [ :index, :show, :new, :create, :update] do
      resources :comments, only: [ :create ]
    end
  end
end
