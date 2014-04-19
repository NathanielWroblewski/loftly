Rails.application.routes.draw do
  root 'welcome#index'

  resources :users

  post '/users/:id', to: 'users#update'
end
