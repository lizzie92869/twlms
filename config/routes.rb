Rails.application.routes.draw do

  resources :weights
  root 'welcome#home'

  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #omniauth
  get '/auth/facebook/callback', to: 'sessions#create'

  get '/sign-up', to: 'users#new'
  resources :users
end
