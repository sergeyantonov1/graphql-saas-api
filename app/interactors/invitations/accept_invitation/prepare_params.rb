# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareParams
      include Interactor

      delegate :user_params, :invitation, to: :context
      delegate :email, :invitee, :company, to: :invitation, prefix: true
      delegate :id, to: :invitation_company, prefix: true
      delegate :id, to: :invitation_invitee, prefix: true

      def call
        context.user_params = build_user_params
        context.membership_params = build_membership_params
        context.invitation_params = build_invitation_params
      end

      private

      def build_user_params
        return {} if invitation_invitee.present?

        user_params.merge(email: invitation_email)
      end

      def build_membership_params
        {
          company_id: invitation_company_id,
          user_id: invitation_invitee_id,
          role: :member
        }
      end

      def build_invitation_params
        {
          accepted_at: Time.current
        }
      end
    end
  end
end
