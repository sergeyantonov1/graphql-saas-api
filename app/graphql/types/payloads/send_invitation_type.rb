# frozen_string_literal: true

module Types
  module Payloads
    class SendInvitationType < Types::BaseObject
      field :token, String, null: false
      field :email, String, null: false
      field :company, Types::CompanyType, null: false
    end
  end
end
