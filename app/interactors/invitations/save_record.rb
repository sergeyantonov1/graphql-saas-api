# frozen_string_literal: true

module Invitations
  class SaveRecord
    include Interactor

    delegate :invitation_params, to: :context

    def call
      return if invitation_params.blank?

      context.fail!(error: error_message) unless save_invitation
    end

    private

    def save_invitation
      invitation.update(invitation_params)
    end

    def invitation
      context.invitation || Invitation.new
    end

    def error_message
      invitation.errors.full_messages.join(", ")
    end
  end
end
