# frozen_string_literal: true

module Invitations
  class CheckInvitee
    include Interactor

    delegate :invitee, :company, to: :context
    delegate :users, :name, to: :company, prefix: true
    delegate :id, to: :invitee, prefix: true

    def call
      return if invitee.blank?

      context.fail!(error_message) if invitee_already_invited?
    end

    private

    def invitee_already_invited?
      company_users.exists?(id: invitee_id)
    end

    def error_message
      I18n.t("errors.messages.already_invited", record_name: "user", company_name: company_name)
    end
  end
end
