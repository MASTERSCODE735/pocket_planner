class CategoriesController < ApplicationController

  def index
    result = Categories::Operation::Index.({params: params, current_user: current_user})
    custom_respond result
  end

  def create
    result = Categories::Operation::Create.({params: params, current_user: current_user})
    custom_respond result
  end

  def show
    result = Categories::Operation::Show.({params: params})
    custom_respond result
  end

end
