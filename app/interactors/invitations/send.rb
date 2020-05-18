# frozen_string_literal: true

module Invitations
  class Send
    include Interactor::Organizer
    include TransactionalInteractor

    organize Invitations::CheckInviteeExistence,
      Invitations::GenerateToken,
      Invitations::SendInvitation::PrepareParams,
      Invitations::SaveRecord
  end
end
