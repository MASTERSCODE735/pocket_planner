module Wallets::Operation
  class Index < Base::Operation::BaseApiOperation
    include HasScope

    has_scope :filter_wallet_name, as: :name
    
    step Policy::Pundit(Wallets::Policy, :check_owner?)
    step :find_all_wallets
    fail :error!
    
    def find_all_wallets(ctx, params:, **)
      ctx[:model] = apply_scopes(Wallet.paginate(page: params[:page],per_page: 3),params)
    end

    def error!(ctx, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"login user can't access all wallets data"
    end
  end
end