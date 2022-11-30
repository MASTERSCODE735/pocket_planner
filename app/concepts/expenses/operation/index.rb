module Expenses::Operation
  class Index < Base::Operation::BaseApiOperation

    include HasScope

    has_scope :filter_expense_name, as: :name
    
    step Policy::Pundit(Expenses::Policy, :index?)
    step :find_all_expense_transactions
      
    def find_all_expense_transactions(ctx, params:, **)
      ctx[:model] = apply_scopes(Transaction.joins(:transaction_type).where(transaction_types: {name: "expense"}).paginate(page: params[:page],per_page: 10), params)
    end
  
  end
end
