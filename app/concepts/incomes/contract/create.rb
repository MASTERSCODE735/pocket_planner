require 'reform/form/dry'
module Incomes::Contract
  class Create < Reform::Form 
    feature Reform::Form::Dry
    
    property :name
    property :amount
    property :wallet_id
    property :user_id
    property :transaction_type_id
    
    validation do 
      params do
          required(:name).filled
          required(:amount).filled
          required(:wallet_id).filled
          required(:user_id).filled
          required(:transaction_type_id).filled
      end 
    end
  
  end
end