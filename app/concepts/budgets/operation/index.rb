module Budgets::Operation
  class Index < Base::Operation::BaseApiOperation
    include HasScope

    has_scope :filter_category_name, as: :name
    
    step Policy::Pundit(Budgets::Policy, :check_owner?)
    step :find_all_budgets
    fail :error!
    
    def find_all_budgets(ctx, params:, **)
      ctx[:model] = apply_scopes(Budget.paginate(page: params[:page],per_page: 10),params)
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"login user can't access all categories data"
    end
  end
end