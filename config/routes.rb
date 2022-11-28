Rails.application.routes.draw do

#   get 'transactions/index'
#   get 'transactions/create'
#   get 'transactions/show'
#   get 'budgets/index'
#   get 'budgets/create'
#   get 'budgets/show'
#   get 'wallets/index'
#   get 'wallets/create'
#   get 'wallets/show'
#   get 'categories/index'
#   get 'categories/create'
#   get 'categories/show'
  devise_for :users, skip: [:sessions,:registrations] 
  
  devise_scope :user do
    post 'sign_up', to: 'users_authentication/registrations#create'
    post 'sign_in', to: 'users_authentication/sessions#create'
  end

  resources :users
  resources :categories
  resources :wallets
  resources :transactions
  resources :budgets
  
end
