# frozen_string_literal: true

module Memberships
  class PrepareOwnerParams
    include Interactor

    delegate :company, :user, to: :context
    delegate :id, :memberships, to: :company, prefix: true
    delegate :id, to: :user, prefix: true
    delegate :id, to: :company, prefix: true

    def call
      context.membership = build_membership
      context.membership_params = membership_params
    end

    private

    def build_membership
      Membership.new
    end

    def membership_params
      {
        role: membership_owner_role,
        user_id: user_id,
        company_id: company_id
      }
    end

    def membership_owner_role
      :owner
    end
  end
end
