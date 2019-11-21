Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips, only: [:new, :show, :create, :update, :index ] do
    resources :trip_form
    resources :invites, only: [ :new, :create]
    resources :trip_items, only: [ :new, :create, :update] do
      resources :comments, only: [ :create ]
      resources :likes, only: [ :create ]


    end
  end
end
