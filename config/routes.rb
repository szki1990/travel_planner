Rails.application.routes.draw do
  
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :destroy]
  end
  
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
    resources :costs, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      collection do
        get 'paid_totals', to: 'costs#paid_totals'
      end
    end
    resources :check_lists, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :categories, only: [:new, :create, :edit, :update, :destroy] do
        resources :items, only: [:new, :create, :edit, :update, :destroy]
      end
    end 
    resources :memos, only: [:new, :create, :index, :destroy, :edit, :show, :update]
    resources :book_comments, only: [:create, :destroy]
  end
 
  resources :users, only: [:index, :show, :edit, :update, :destroy]
end