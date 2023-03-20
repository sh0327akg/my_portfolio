Rails.application.routes.draw do
  root to: 'static_pages#top'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
  get 'help', to: 'static_pages#help'

  get "/auth/github/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/sign_out", to: "sessions#destroy"

  resources :contributions
  resources :users, only: %i[show] do
    get 'contribution_history', on: :member
  end
  get "/ranks", to: "ranks#rank"
end
