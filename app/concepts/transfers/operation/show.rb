module Transfers::Operation
    class Show < Base::Operation::BaseApiOperation
      step Policy::Pundit(Transfers::Policy, :show?)
      step :show_transfers
      fail :error!

    def show_transfers(ctx, params:, **)
      ctx[:model] = Transaction.where(id: params[:id]).joins(:transaction_type).where(transaction_types: {name: ["transfer_in","transfer_out"]})
      return false if ctx[:model].empty?
      true
    end

    def error!(ctx, current_user:, **)
      ctx[:http_status_code] = 400
      add_errors ctx,"transfer not present"
    end
  end
end