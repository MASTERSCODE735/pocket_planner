module Users::Operation
  class Index < Base::Operation::BaseApiOperation

    include HasScope

    has_scope :filter_name, as: :name

    step Policy::Pundit(Users::Policy, :check_owner?)
    step :find_all_users
    fail :error!
    
    def find_all_users(ctx, params:, **)
      ctx[:model] = apply_scopes(User.paginate(page: params[:page],per_page: 10),params)
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"login user can't access all users data"
    end

  end
end