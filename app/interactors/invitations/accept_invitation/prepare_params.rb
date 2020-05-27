# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareParams
      include Interactor

      delegate :invitation, to: :context
      delegate :email, :company, to: :invitation, prefix: true

      def call
        context.email = invitation_email
        context.company = invitation_company
        context.invitation_params = build_invitation_params
      end

      private

      def build_invitation_params
        {
          accepted_at: Time.current
        }
      end
    end
  end
end
