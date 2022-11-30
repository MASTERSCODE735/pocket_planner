module Transfers::Operation
  class Index < Base::Operation::BaseApiOperation
    include HasScope

    has_scope :filter_expense_name, as: :name
    
    step Policy::Pundit(Transfers::Policy, :index?)
    step :find_all_transfers_transactions
      
    def find_all_transfers_transactions(ctx, params:, **)
      ctx[:model] = apply_scopes(Transaction.joins(:transaction_type).where(transaction_types: {name: ["transfer_out","transfer_in"]}).paginate(page: params[:page],per_page: 10), params)
    end
    
  end
end