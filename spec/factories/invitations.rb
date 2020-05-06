# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    email { FFaker::Internet.email }
    association :invited_by, factory: :user
    association :invitee, factory: :user
    company
    token { "some_token" }
  end
end
