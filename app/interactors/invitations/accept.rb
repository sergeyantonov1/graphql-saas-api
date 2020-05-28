# frozen_string_literal: true

module Invitations
  class Accept
    include Interactor::Organizer
    include TransactionalInteractor

    organize Invitations::FindRecord,
      Invitations::AcceptInvitation::PrepareParams,
      Invitations::CheckInviteeExistence,
      Invitations::SaveRecord,
      Invitations::AcceptInvitation::PrepareUserParams,
      Users::SaveRecord,
      Invitations::AcceptInvitation::PrepareMembershipParams,
      Memberships::SaveRecord
  end
end
