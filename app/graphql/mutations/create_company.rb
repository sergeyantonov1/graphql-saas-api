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
      Companies::SaveRecord.call(company: build_company, company_params: params)
    end

    def build_company
      current_user.companies.build
    end
  end
end
