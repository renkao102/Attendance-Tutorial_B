Rails.application.routes.draw do
  
  get 'posts/base', to: 'posts#base'
  get '/admin', to: 'users#index'
  
  get "User/index" => "users#index"
  get "User/new" => "users#new"
  post "User/create" => "users#create"
  
  resources :restaurants, only: [:index, :show] 
  namespace :admin do
  resources :restaurants, only: [:base, :index, :new, :create, :show, :edit, :destroy]
  end
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month' # この行が追加対象です。
    end
    resources :attendances, only: :update
  end
end