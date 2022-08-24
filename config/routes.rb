Rails.application.routes.draw do
  devise_for :users
   root to: "boards#index"

  resources :boards do
    resources :comments, only: [:new, :create]


    resources :tasks, only: [:create, :destroy]

  end

  resource :profile, only: [:show, :edit, :update]
  resources :favorites, onle: [:index]
end

