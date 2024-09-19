Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "dashboards", to: "dashboards#index"
    resources :users, only: [:show, :destroy]
    resources :books, only: [:index, :show, :edit, :destroy] do
      resources :book_comments, only: [:destroy]
      resources :schedules, only: [:index, :show, :edit, :destroy]
    end
  end

  root "homes#top"

  devise_for :users

  get "homes/top", to: "homes#top"
  get "about", to: "homes#about", as: "about"
  get "mypage", to: "users#my_page", as: "my_page"

  patch "toggle_completed/:id", to: "items#toggle_completed", as: "toggle_completed_item"


  resources :books do
    collection do
      get "public_index", to: "books#public_index"
    end

    member do
      delete :destroy_image
    end

    resources :schedules, only: [:new, :create, :index, :edit, :destroy, :update, :show]
    resources :costs, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      collection do
        get "paid_totals", to: "costs#paid_totals"
        get "payment_method_index", to: "costs#payment_method_index"
      end
    end
    resources :check_lists, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :categories, only: [:new, :create, :edit, :update, :destroy] do
        resources :items, only: [:new, :create, :edit, :update, :destroy]
      end
    end
    resources :memos, only: [:new, :create, :index, :destroy, :edit, :show, :update]
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resources :books, only: [:show]
    member do
      get :followings
      get :followers
    end
  end
  resources :favorites, only: [:index]
  resource :maps, only: [:show]
  resources :relationships, only: [:create, :destroy]
end
