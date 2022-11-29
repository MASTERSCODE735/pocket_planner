class TransfersController < ApplicationController
    def index
      result = Transfers::Operation::Index.({params: params, current_user: current_user})
      custom_respond result
    end
  
    def create
      result = Transfers::Operation::Create.(params: params, current_user: current_user)
      custom_respond result
    end
  
    def show
      result = Transfers::Operation::Show.({params: params, current_user: current_user})
      custom_respond result
    end
end
  