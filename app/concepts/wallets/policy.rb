class Wallets::Policy < ApplicationPolicy
    def check_owner?
      user&.user_group_owner
    end

    def show? 
        true 
    end

end
