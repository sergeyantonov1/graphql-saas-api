# frozen_string_literal: true

module Types
  class MembershipType < Types::BaseObject
    field :id, ID, null: false
    field :role, String, null: false
    field :user, Types::UserType, null: false
    field :company, Types::CompanyType, null: false
  end
end
