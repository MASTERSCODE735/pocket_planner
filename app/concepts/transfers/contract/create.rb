require 'reform/form/dry'
module Transactions::Contract
    class Create < Reform::Form 
      feature Reform::Form::Dry
    end
end