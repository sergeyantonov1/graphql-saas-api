# frozen_string_literal: true

module Types
  module Payloads
    class AcceptInvitationType < Types::BaseObject
      field :membership, Types::MembershipType, null: false
    end
  end
end
