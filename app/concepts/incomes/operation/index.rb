module Incomes::Operation
  class Index < Base::Operation::BaseApiOperation

    include HasScope

    has_scope :filter_income_name, as: :name

    step Policy::Pundit(Incomes::Policy, :index?)
    step :find_all_income_transactions
      
    def find_all_income_transactions(ctx, params:, **)
      ctx[:model] = apply_scopes(Transaction.joins(:transaction_type).where(transaction_types: {name: "income"}).paginate(page: params[:page],per_page: 10), params)
    end
    
  end
end