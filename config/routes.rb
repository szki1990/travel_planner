Rails.application.routes.draw do
 
  devise_for :users
  
  resources :books, only: [:new, :create, :index, :show]
  get 'homes/top', to: 'homes#top' 
  root 'homes#top'
  get 'about', to: 'homes#about', as: 'about'
  resources :users, only: [:show, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
