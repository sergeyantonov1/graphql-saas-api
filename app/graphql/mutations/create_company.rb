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
        company: build_company,
        company_params: params,
        user: current_user
      )
    end

    def build_company
      ::Company.new
    end
  end
end
