module Base::Operation
  class BaseApiOperation < Trailblazer::Operation

    def success_message(ctx, success_message = nil)
      if success_message.nil?
        ctx[:success] = []
      elsif ctx[:success].nil?
        ctx[:success] = success_message
      else
        ctx[:success]
      end  
    end

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
