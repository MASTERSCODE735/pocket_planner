module Users::Operation
  class Show < Base::Operation::BaseApiOperation
    step Model(User,:find_by)
    fail :error!

    def error!(ctx, params:,**)
      ctx[:http_status_code] = 400
      add_errors ctx,"users does not belong to this group"
    end

  end
end
