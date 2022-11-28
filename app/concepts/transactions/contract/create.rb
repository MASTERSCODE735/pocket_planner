require 'reform/form/dry'
module Transactions::Contract
    class Create < Reform::Form 
      feature Reform::Form::Dry
      
      property :name
      property :date
      property :transaction_type_id
      property :wallet_id
      property :amount
      
      validation do 
        params do
            required(:name).filled
            required(:date).filled
            required(:transaction_type_id)
            required(:wallet_id)
            required(:amount)
        end 
      end

    end
end