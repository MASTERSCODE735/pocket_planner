module Wallets::Operation
  class Show < Base::Operation::BaseApiOperation

    step Model(Wallet,:find_by)
    
  end
end