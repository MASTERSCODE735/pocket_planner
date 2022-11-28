module Users::Operation
  class Show < Base::Operation::BaseApiOperation
    step Model(User,:find_by)

  end
end
