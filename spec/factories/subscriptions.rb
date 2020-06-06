# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    user
    stripe_subscription_id { nil }
    status { "free" }
  end
end
