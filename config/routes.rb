Rails.application.routes.draw do
  root to: 'static_pages#top'

  resources :contributions
  resources :users, only: %i[show]
end
