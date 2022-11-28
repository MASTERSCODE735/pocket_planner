module Users::Operation
    class Create < Base::Operation::BaseApiOperation
      step Model(User,:new)
      step Policy::Pundit(Users::Policy, :check_owner?)
      step Contract::Build(constant: Users::Contract::Create)
      step Contract::Validate()
      step Contract::Persist()
      fail :error!

      def error!(ctx, **)
        error_messages= []
        error_messages << (ctx["result.policy.default"][:message].present? ? "user unauthorized" : "")
        error_messages << ctx["contract.default"]&.errors&.messages
        add_errors ctx, error_messages
      end
      
    end
end