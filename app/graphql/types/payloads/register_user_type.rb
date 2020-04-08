# frozen_string_literal: true

module Types
  module Payloads
    class RegisterUserType < Types::BaseObject
      field :token, String, null: false
      field :user, Types::UserType, null: false
    end
  end
end
