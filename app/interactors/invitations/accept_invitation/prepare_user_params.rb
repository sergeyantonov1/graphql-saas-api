# frozen_string_literal: true

module Invitations
  module AcceptInvitation
    class PrepareUserParams
      include Interactor

      delegate :user_params, :invitation, to: :context
      delegate :email, to: :invitation, prefix: true

      def call
        context.user = find_or_initialize_user
        context.user_params = build_user_params
      end

      private

      def find_or_initialize_user
        @find_or_initialize_user ||= User.find_or_initialize_by(email: invitation_email)
      end

      def build_user_params
        user_params.to_h.merge(email: invitation_email) if find_or_initialize_user.new_record?
      end
    end
  end
end
