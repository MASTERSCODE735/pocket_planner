require 'reform/form/dry'
module Categories::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :name

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
