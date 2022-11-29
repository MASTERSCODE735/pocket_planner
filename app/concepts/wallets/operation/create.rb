module Wallets::Operation
  class Create < Base::Operation::BaseApiOperation
    step Model(Wallet,:new)
    step Contract::Build(constant: Wallets::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    step :success!
    step :error!

    def error!(ctx, **)
      add_errors ctx, ctx["contract.default"]&.errors&.messages
    end

    def success!(ctx, model:, **)
      ctx[:http_status_code] = 201
      success_message ctx,"Wallet Successfully Created"
    end

  end
end