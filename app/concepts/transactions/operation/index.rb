module Transactions::Operation
  class Index < Base::Operation::BaseApiOperation

    # include HasScope

    # has_scope :filter_category_name, as: :name apply_scopes(
    
    step Policy::Pundit(Categories::Policy, :check_owner?)
    step :find_all_transactions
    fail :error!
    
    def find_all_transactions(ctx, params:, **)
      ctx[:model] = Transaction.paginate(page: params[:page],per_page: 10)
    end
    
  end
end