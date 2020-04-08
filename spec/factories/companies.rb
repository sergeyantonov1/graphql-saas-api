# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { FFaker::Company.name }
  end
end
