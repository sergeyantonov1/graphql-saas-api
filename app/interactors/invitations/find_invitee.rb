# frozen_string_literal: true

module Invitations
  class FindInvitee
    include Interactor

    delegate :email, to: :context

    def call
      context.invitee = invitee
    end

    private

    def invitee
      User.find_by(email: email)
    end
  end
end
