# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    field :status, String, null: false
  end
end
