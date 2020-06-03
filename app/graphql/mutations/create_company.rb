# frozen_string_literal: true

module Mutations
  class CreateCompany < BaseMutation
    include AuthenticableApiUser

    argument :name, String, required: true

    type Types::Payloads::CreateCompanyType

    def resolve(**params)
      result = create_company(params)

      result.success? ? result : execution_error(message: result.error)
    end

    private

    def create_company(params)
      Companies::Create.call(
        company_params: params,
        user: current_user
      )
    end
  end
end
