Rails.application.routes.draw do

  root 'welcome#home'

  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/sign-up', to: 'users#new'
  resources :users
end
