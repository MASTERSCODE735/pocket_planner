module Users::Operation
  class Index < Base::Operation::BaseApiOperation
    step :check_owner
    step :find_all_post
    fail :error!

    def check_owner(ctx,params:, current_user:, **)
      current_user.user_group_owner
    end
    
    def find_all_post(ctx, params:, **)
      ctx[:model] = User.paginate(page: params[:page],per_page: 10)
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"#{current_user.email} can't access all users data"
    end

  end
end