# frozen_string_literal: true

module Types
  module Payloads
    class CreateSubscriptionType < Types::BaseObject
      field :subscription, Types::SubscriptionType, null: false
    end
  end
end
