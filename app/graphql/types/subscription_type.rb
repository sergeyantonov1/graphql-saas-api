# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    field :status, String, null: false
    field :stripe_subscription_id, String, null: true
  end
end
