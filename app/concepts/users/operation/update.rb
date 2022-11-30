module Users::Operation
  class Update < Base::Operation::BaseApiOperation

    step Model(User, :find_by_id)
    step Contract::Build(constant: Users::Contract::Update)
    step Contract::Validate()
    step Contract::Persist()
    fail :error!

    def error!(ctx, **)
      add_errors ctx, ctx["contract.default"]&.errors&.messages
    end
    
  end
end