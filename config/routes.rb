Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tour_stores do
    resources :activities, only: [:new, :create]
  end
  resources :activities, only: [:update, :edit, :destroy, :show]
  get 'tour_stores/:id/dashboard', to: 'tour_stores#dashboard', as: :dashboard
  get 'terms', to: 'pages#terms'
  get 'about', to: 'pages#about'
end
