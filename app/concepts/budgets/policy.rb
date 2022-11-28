class Budgets::Policy < ApplicationPolicy
    
    def create?
      current_user.user_group_owner
    end

    def index?
      current_user.user_group_owner
    end

    def show?
      current_user.user_group_owner
    end

end
