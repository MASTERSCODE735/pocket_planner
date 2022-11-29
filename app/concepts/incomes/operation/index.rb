module Incomes::Operation
    class Index < Base::Operation::BaseApiOperation

      include HasScope

      has_scope :filter_income_name, as: :name

      step Policy::Pundit(Incomes::Policy, :index?)
      step :find_all_income_transactions
        
      def find_all_income_transactions(ctx, params:, **)
        ctx[:model] = apply_scopes(Transaction.where(transaction_type_id: TransactionType.find_by(name: "income").id).paginate(page: params[:page],per_page: 10), params)
      end
      
    end
end