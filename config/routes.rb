Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tour_stores, param: :slug do
    get 'dashboard', to: 'tour_stores#dashboard', as: :dashboard
    get 'tours', to: 'tour_stores#tours'
    get 'users', to: 'tour_stores#users'
    get 'events', to: 'tour_stores#events'
    resources :tour_store_admins, only: [:create, :new, :destroy]
    resources :activities, param: :slug, only: [:edit, :update, :new, :create] do
      get 'audit', to: 'activities#audit', as: :audit
    end
  end
  resources :tour_store_admins, only: [:edit, :update, :destroy]
  resources :activities, param: :slug, only: [:show, :destroy] do
    resources :orders, only: [:create, :new]
  end

  resources :orders, only:[:show, :update, :edit, :destroy, :index]
  get 'terms', to: 'pages#terms'
  get 'about', to: 'pages#about'
  get 'cadastro', to: 'pages#cadastro'
  get 'landing_page', to: 'pages#landing_page'
  get 'examples', to: 'pages#dummy_stores'
  get 'home', to: 'pages#home'
  resources :leads, only: [:create]
  resources :photos, only: [:show, :destroy]
  get 'activities/:id/:activity_name', to: 'activities#show'
end
