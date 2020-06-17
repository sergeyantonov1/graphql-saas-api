# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    field :status, String, null: false
    field :user, Types::UserType, null: false
  end
end
