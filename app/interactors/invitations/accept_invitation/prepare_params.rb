# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareParams
      include Interactor

      def call
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
