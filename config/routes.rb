Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'static_pages#top'

  resources :contributions
end
