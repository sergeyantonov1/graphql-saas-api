# frozen_string_literal: true

class Send
  include Interactor::Organizer
  include TransactionalInteractor

  organize Invitations::FindInvitee,
    Invitations::CheckAvailability,
    Invitations::GenerateToken,
    Invitations::SendInvitation::PrepareParams,
    Invitations::SaveRecord,
    Invitations::SendEmail
end
