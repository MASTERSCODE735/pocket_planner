require 'reform/form/dry'
module Wallets::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :name
    property :user_id
    property :opening_balance

    validation do
      params do
        required(:name).filled
        required(:user_id).filled
        required(:opening_balance).filled
      end
    end
  end
end
