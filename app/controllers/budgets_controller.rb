class BudgetsController < ApplicationController
    def index
        result = Budgets::Operation::Index.({params: params, current_user: current_user})
        custom_respond result
      end
    
      def create
        result = Budgets::Operation::Create.({params: params, current_user: current_user})
        custom_respond result
      end
    
      def show
        result = Budgets::Operation::Show.({params: params})
        custom_respond result
      end
end
