module Categories::Operation
  class Create < Base::Operation::BaseApiOperation
    step Model(Category,:new)
    step Policy::Pundit(Categories::Policy, :check_owner?)
    step Contract::Build(constant: Categories::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    step :success!
    fail :error!

    def error!(ctx, **)
      error_messages= []
      error_messages << (ctx["result.policy.default"][:message].present? ? "user unauthorized" : "")
      error_messages << ctx["contract.default"]&.errors&.messages
      add_errors ctx, error_messages
    end

    def success!(ctx, model:, **)
      ctx[:http_status_code] = 201
      success_message ctx,"Category Successfully Created"
    end

  end
end
