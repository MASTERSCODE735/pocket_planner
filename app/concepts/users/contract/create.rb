require 'reform/form/dry'
module Users::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :first_name
    property :last_name
    property :mobile_number

    validation do
      params do
        required(:first_name).filled
        required(:last_name).filled
        required(:mobile_number).filled
      end
    end
  end
end