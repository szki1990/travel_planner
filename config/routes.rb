Rails.application.routes.draw do
  resources :books do
    collection do
      get 'public_index', to: 'books#public_index'
    end
  end
 
  get 'posts/index'
  devise_for :users
  
  get 'homes/top', to: 'homes#top' 
  get 'mypage', to:'users#my_page', as:'my_page'
  root 'homes#top'
  get 'about', to: 'homes#about', as: 'about'
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :books, only: [:new, :create, :index, :show, :edit, :destroy]
  #resources :posts, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
