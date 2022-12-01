require 'reform/form/dry'
module Users::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :email
    property :password
    property :password_confirmation

    validation do
      params do
        required(:password).filled
        required(:password_confirmation).filled
      end
    end

    validation email: :default do
      option :form
  
      params do
        required(:email).filled
      end
  
      rule(:email) do
        key.failure('must be unique') if Category.where.not(id: form.model.id).where(email: value).exists?
      end
    end
    
  end
end
