module Users::Operation
    class Create < Base::Operation::BaseApiOperation
      step Model(User,:new)
      step Contract::Build(constant: Users::Contract::Create)
      step Contract::Validate()
      step Contract::Persist()
      fail :error!

      def error!(ctx, **)
        add_errors ctx, ctx["contract.default"]&.errors&.messages
      end
      
    end
end