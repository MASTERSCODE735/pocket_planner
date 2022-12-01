require 'reform/form/dry'
module Budgets::Contract
  class Create < Reform::Form
    feature Reform::Form::Dry

    property :budget_name
    property :start_date
    property :end_date
    property :category_id
    
    validation do 
      params do
        required(:start_date).filled
        required(:end_date).filled
        required(:category_id).filled
      end 
    end

    validation budget_name: :default do
      option :form
  
      params do
        required(:budget_name).filled
      end
  
      rule(:budget_name) do
        key.failure('must be unique') if Budget.where.not(id: form.model.id).where(budget_name: value).exists?
      end
    end

  end
end