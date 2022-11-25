class UsersController < ApplicationController

    has_scope :filter_name, only: :index
    
    def create
      result = Users::Operation::Create.({params: params})
      custom_respond result
    end

    def index
      result = Users::Operation::Index.({params: params, current_user: current_user})
      result = (result[:model].nil? ? result : apply_scopes(result[:model]))
      custom_respond result
    end

    def update
      params[:id] = current_user.id
      result = Users::Operation::Update.({params: params})
      custom_respond result
    end

    def show
      result = Users::Operation::Show.({params: params})
      custom_respond result
    end

end
