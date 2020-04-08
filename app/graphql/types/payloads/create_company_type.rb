# frozen_string_literal: true

module Types
  module Payloads
    class CreateCompanyType < Types::BaseObject
      field :company, Types::CompanyType, null: false
    end
  end
end
