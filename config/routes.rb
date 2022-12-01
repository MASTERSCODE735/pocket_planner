Rails.application.routes.draw do

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

  post 'expenses', to: 'expenses#create'
  get 'expenses', to: 'expenses#index' 
  get 'expenses/period-on-period', to: 'expenses#period'
  get 'expenses/:id', to: 'expenses#show'

  post 'incomes', to: 'incomes#create'
  get 'incomes', to: 'incomes#index' 
  get 'incomes/:id', to: 'incomes#show'

  post 'transfers', to: 'transfers#create'
  get 'transfers', to: 'transfers#index' 
  get 'transfers/:id', to: 'transfers#show'
  
end
