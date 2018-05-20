Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tour_stores do
    get 'dashboard', to: 'tour_stores#dashboard', as: :dashboard
    get 'tours', to: 'tour_stores#tours', as: :tours
    get 'users', to: 'tour_stores#users', as: :users

    resources :activities, only: [:new, :create, :edit, :update] do
      get 'audit', to: 'activities#audit', as: :audit
    end
  end
  resources :activities, only: [:destroy, :show]
  get 'terms', to: 'pages#terms'
  get 'about', to: 'pages#about'
  get 'cadastro', to: 'pages#cadastro'
end
