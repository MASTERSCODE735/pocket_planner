module Expenses::Operation
    class Index < Base::Operation::BaseApiOperation

      include HasScope

      has_scope :filter_expense_name, as: :name
      
      step Policy::Pundit(Expenses::Policy, :index?)
      step :find_all_expense_transactions
        
      def find_all_expense_transactions(ctx, params:, **)
        ctx[:model] = apply_scopes(Transaction.where(transaction_type_id: TransactionType.find_by(name: "expense").id).paginate(page: params[:page],per_page: 10), params)
      end
    
    end
end