# frozen_string_literal: true

module Types
  class LoginUserPayloadType < Types::BaseObject
    field :token, String, null: false
    field :user, Types::UserType, null: false
  end
end
