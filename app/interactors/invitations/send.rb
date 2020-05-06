# frozen_string_literal: true

class Send
  include Interactor::Organizer
  include TransactionalInteractor

  organize Invitations::FindInvitee,
    Invitations::GenerateToken,
    Invitations::SendInvitation::PrepareParams,
    Invitations::SaveRecord
end
