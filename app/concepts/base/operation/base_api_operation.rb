module Base::Operation
  class BaseApiOperation < Trailblazer::Operation

    def add_errors(ctx, error_messages = nil)
      if error_messages.nil?
        ctx[:errors] = []
      elsif  ctx[:errors].nil?
        ctx[:errors] = error_messages
      else
        ctx[:errors]
      end
    end

  end
end
