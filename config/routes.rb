Rails.application.routes.draw do

  get 'users/base', to: 'users#base'

  get '/admin', to: 'users#index'
  get '/admin', to: 'attendance#edit_tytle'
  get '/admin', to: 'users#base'
  get '/admin', to: 'users#show'
  
  get "User/index" => "users#index"
  get "User/new" => "users#new"
  get "User/show" => "users#show"
  post "User/create" => "users#create"
  get "User/base" => "users#base"
  get "User/edit" => "users#edit"

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
      get 'base'
      patch 'update_base'
      get 'attendances/edit_one_month'
      get 'attendances/edit_tytle' # この行が追加対象です
      patch 'attendances/update_one_month' # この行が追加対象です
    end
    resources :attendances, only: :update
  end
end
