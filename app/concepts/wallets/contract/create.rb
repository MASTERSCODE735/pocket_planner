require 'reform/form/dry'
module Wallets::Contract
  class Create < Reform::Form

    feature Reform::Form::Dry

    property :name
    property :user_id
    property :opening_balance

    validation do
      params do
        required(:user_id).filled
        required(:opening_balance).filled
      end
    end
    
    validation name: :default do
      option :form
  
      params do
        required(:name).filled
      end
  
      rule(:name) do
        key.failure('must be unique') if Category.where.not(id: form.model.id).where(name: value).exists?
      end
    end
    

  end
end
