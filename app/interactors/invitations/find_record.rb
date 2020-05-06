# frozen_string_literal: true

module Invitations
  class FindRecord
    include Interactor

    delegate :token, to: :context

    def call
      context.invitation = find_invitation

      context.fail!(error_message) if context.invitation.blank?
    end

    private

    def find_invitation
      Invitation.find_by(token: token, accepted_at: nil)
    end

    def error_message
      I18n.t("errors.messages.record_not_found", record_name: "invitation")
    end
  end
end
