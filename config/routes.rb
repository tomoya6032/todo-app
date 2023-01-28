Rails.application.routes.draw do
  devise_for :users
   root to: 'boards#index'

  resources :boards do
    resources :tasks, only: [:new, :show, :edit, :create, :update, :destroy] do
      resources :comments, only: [:new, :create]
    end
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
  end

  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
end
