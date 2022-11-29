class Expenses::Policy < ApplicationPolicy
    def create?
      user 
    end

    def index?
      user
    end

    def show?
      user
    end
end
