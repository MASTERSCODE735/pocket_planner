require 'reform/form/dry'
module Users::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :email
    property :password
    property :password_confirmation

    validation do
      params do
        required(:email).filled
        required(:password).filled
        required(:password_confirmation).filled
      end
    end
  end
end
