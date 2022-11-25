Rails.application.routes.draw do

  devise_for :users, skip: [:sessions,:registrations] 
  
  devise_scope :user do
    post 'sign_up', to: 'users_authentication/registrations#create'
    post 'sign_in', to: 'users_authentication/sessions#create'
  end

  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  resource :users
  
end
