# frozen_string_literal: true

module Invitations
  class FindRecord
    include Interactor

    delegate :token, to: :context

    def call
      context.fail!(error: error_message) if invitation.blank?

      context.invitation = invitation
    end

    private

    def invitation
      @invitation ||= Invitation.find_by(token: token, accepted_at: nil)
    end

    def error_message
      I18n.t("errors.messages.record_not_found", model_name: "Invitation")
    end
  end
end
