require 'reform/form/dry'
module Categories::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :name

    validation do
      params do
        required(:name).filled
      end
    end
  end
end
