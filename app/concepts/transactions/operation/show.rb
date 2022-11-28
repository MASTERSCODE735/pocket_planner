module Transactions::Operation
    class Show < Base::Operation::BaseApiOperation

        step Model(Transaction, :find_by)

    end
  end