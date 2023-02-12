Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#top'

  resources :contributions
end
