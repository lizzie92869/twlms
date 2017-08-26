Rails.application.routes.draw do

  get '/sign-in', to: 'sessions#new', as: 'new_session'
  post '/sign-in', to: 'sessions#create', as: 'session'
  delete '/log-out', to: 'sessions#destroy'

  get '/sign-up', to: 'users#new', as: 'new_sign_up'
  resources :users
end
