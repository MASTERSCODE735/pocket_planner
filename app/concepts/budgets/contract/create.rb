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
          required(:budget_name).filled
          required(:start_date).filled
          required(:end_date).filled
          required(:category_id).filled
      end 
    end

  end
end