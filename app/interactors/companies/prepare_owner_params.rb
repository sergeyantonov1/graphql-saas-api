# frozen_string_literal: true

module Companies
  class PrepareOwnerParams
    include Interactor

    delegate :company, :user, to: :context
    delegate :id, :memberships, to: :company, prefix: true
    delegate :id, to: :user, prefix: true

    def call
      context.membership = build_membership
      context.membership_params = membership_params
    end

    private

    def build_membership
      company_memberships.build
    end

    def membership_params
      {
        role: membership_owner_role,
        user_id: user_id
      }
    end

    def membership_owner_role
      :owner
    end
  end
end
