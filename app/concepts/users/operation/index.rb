module Users::Operation
  class Index < Trailblazer::Operation
    step :find_all_post

    def find_all_post(ctx,params:, **)
      ctx[:model] = User.paginate(page: params[:page],per_page: 10)
    end
  end
end