# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareMembershipParams
      include Interactor

      delegate :invitation, to: :context
      delegate :invitee_id, :company_id, to: :invitation, prefix: true

      def call
        context.membership_params = build_membership_params
      end

      private

      def build_membership_params
        {
          company_id: invitation_company_id,
          user_id: invitation_invitee_id,
          role: :member
        }
      end
    end
  end
end
