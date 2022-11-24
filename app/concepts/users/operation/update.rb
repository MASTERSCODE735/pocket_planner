module Users::Operation
    class Update < Trailblazer::Operation
        step Model(User, :find_by_id)
        step Contract::Build(constant: Users::Contract::Create)
        step Contract::Validate()
        step Contract::Persist()
    end
end