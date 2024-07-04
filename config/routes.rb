Rails.application.routes.draw do
  root 'homes#top'
  
  devise_for :users
  
  get 'homes/top', to: 'homes#top'
  get 'about', to: 'homes#about', as: 'about'
  get 'mypage', to:'users#my_page', as:'my_page'
  
  resources :books do
    collection do
      get 'public_index', to: 'books#public_index'
    end
    resources :schedules, only: [:new, :create, :index, :edit, :destroy, :update, :show]
    resources :costs, only: [:new, :create, :index, :show, :edit]
    resources :check_lists, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :memos, only: [:new, :create, :index, :destroy, :edit, :show, :update]
  end
 
  resources :schedules, only: [:edit, :update, :destroy, :show]
  resources :users, only: [:show, :edit, :update, :destroy]
end