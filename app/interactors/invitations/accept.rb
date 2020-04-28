# frozen_string_literal: true

module Invitations
  class Accept
    include Interactor::Organizer
    include TransactionalInteractor

    organize Invitations::FindRecord,
      Invitations::AcceptInvitation::PrepareParams,
      Users::SaveRecord,
      Memberships::SaveRecord,
      Invitations::SaveRecord
  end
end
