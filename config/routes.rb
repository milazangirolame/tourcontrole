Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#landing_page'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tour_stores do
    get 'dashboard', to: 'tour_stores#dashboard', as: :dashboard
    get 'tours', to: 'tour_stores#tours', as: :tours
    get 'users', to: 'tour_stores#users', as: :users

    resources :activities, only: [:new, :create, :edit, :update] do
      get 'audit', to: 'activities#audit', as: :audit
    end
  end
  resources :activities, only: [:destroy, :show] do
    resources :orders, only: [:create, :new]
  end
  resources :orders, only:[:show, :update, :edit, :destroy, :index]
  get 'terms', to: 'pages#terms'
  get 'about', to: 'pages#about'
  get 'cadastro', to: 'pages#cadastro'
  get 'landing_page', to: 'pages#landing_page'
  get 'examples', to: 'pages#dummy_stores'
  resources :leads, only: [:create]
end
