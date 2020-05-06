# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareUserParams
      include Interactor

      delegate :user_params, :invitation, to: :context
      delegate :email, :invitee_id, to: :invitation, prefix: true

      def call
        context.user_params = build_user_params
      end

      private

      def build_user_params
        return if invitation_invitee_id.present?

        user_params.merge(email: invitation_email)
      end
    end
  end
end
