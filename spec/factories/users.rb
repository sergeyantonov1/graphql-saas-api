# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    stripe_customer_id { nil }
    password { "password" }
    password_confirmation { "password" }
  end
end
