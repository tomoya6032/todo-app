Rails.application.routes.draw do
  devise_for :users
   root to: "boards#index"
   

  resources :boards do
    resources :comments, only: [:new, :create]
    resources :tasks, only: [:new, :show, :create, :destroy]
  end

  resources :tasks, only:[:show, :new, :create, :destroy, :edit, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
end

