# frozen_string_literal: true

module Invitations
  module SendInvitation
    class PrepareParams
      include Interactor

      delegate :email, :invitee, :sender, :token, :company, to: :context

      def call
        context.invitation_params = build_invitation_params
      end

      private

      def build_invitation_params
        {
          email: email,
          invitee: invitee,
          sender: sender,
          token: token,
          company: company
        }
      end
    end
  end
end
