module Wallets::Operation
  class Show < Base::Operation::BaseApiOperation

    step Policy::Pundit(Wallets::Policy, :show?)
    step Model(Wallet,:find_by)
    
  end
end