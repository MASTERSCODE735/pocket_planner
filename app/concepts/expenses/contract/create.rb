require 'reform/form/dry'
module Expenses::Contract
    class Create < Reform::Form 
      feature Reform::Form::Dry
      
      property :name
      property :date
      property :amount
      property :wallet_id
      property :category_id
      property :user_id
      property :transaction_type_id
      
      validation do 
        params do
            required(:name).filled
            required(:date).filled
            required(:amount).filled
            required(:wallet_id).filled
            required(:category_id).filled
            required(:user_id).filled
            required(:transaction_type_id).filled
        end 
      end
    
    end
end