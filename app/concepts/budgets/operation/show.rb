module Budgets::Operation
  class Show < Base::Operation::BaseApiOperation

    step Model(Budget,:find_by)
    
  end
end