require 'date'
module Incomes::Operation
  class Create < Base::Operation::BaseApiOperation

    step :add_transaction_type_user_id
    step Model(Transaction,:new)
    step Policy::Pundit(Incomes::Policy, :create?)
    step Contract::Build(constant: Incomes::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()

    def add_transaction_type_user_id(ctx, params:, current_user:, **)
      params[:date] = DateTime.now
      params[:user_id] = current_user.id
      params[:transaction_type_id] = TransactionType.id_for(:income)
    end

  end
end