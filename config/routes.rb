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
    resources :schedules, only: [:new, :create, :index]
    resources :costs, only: [:new, :create, :index]
    resources :check_lists, only: [:new, :create, :index]
    resources :memos, only: [:new, :create, :index]
  end
 #get 'posts/index'
  resources :schedules, only: [:edit, :update, :destroy, :show]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :costs, only: [:new, :index, :show, :edit]
  resources :check_list, only: [:new, :index, :show, :edit]
  #resources :posts, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

