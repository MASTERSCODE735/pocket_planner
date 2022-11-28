module Categories::Operation
  class Show < Base::Operation::BaseApiOperation

    step Model(Category,:find_by)
    
  end
end