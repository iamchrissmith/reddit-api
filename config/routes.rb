Rails.application.routes.draw do
  root 'home#index'

  get '/auth/reddit/callback', as: :reddit_login, to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:show]
end
