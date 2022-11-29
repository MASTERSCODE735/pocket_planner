module Incomes::Operation
  class Create < Base::Operation::BaseApiOperation
    step Model(Transaction,:new)
    step Policy::Pundit(Incomes::Policy, :create?)
    step Contract::Build(constant: Incomes::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()

  end
end