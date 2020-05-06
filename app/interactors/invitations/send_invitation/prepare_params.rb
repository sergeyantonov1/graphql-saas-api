# frozen_string_literal: true

module Invitations
  module SendInvitation
    class PrepareParams
      include Interactor

      delegate :invitee, :invited_by, :token, :company, to: :context

      def call
        context.invitation_params = build_invitation_params
      end

      private

      def build_invitation_params
        {
          invitee: invitee,
          invited_by: invited_by,
          token: token,
          company: company
        }
      end
    end
  end
end
