Rails.application.routes.draw do
  get '/sample', to: 'sample#test'
  devise_for :users, skip: [:sessions,:registrations] 
  devise_scope :user do
    post 'signin', to: 'users/sessions#create', as: :user_session
  end
 
end
