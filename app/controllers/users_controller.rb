class UsersController < ApplicationController

    has_scope :filter_name, only: :index

    def index
      result = run Users::Operation::Index
      render json: apply_scopes(result[:model])
    end

    def update
      result = run Users::Operation::Update
      render json: (result[:model])
    end

    def show   
      result = run Users::Operation::Show
      render json: (result[:model])
    end
end
