# frozen_string_literal: true

require "rails_helper"

describe Invitations::Accept do
  describe ".organized" do
    let(:expected_interactors) do
      [
        Invitations::FindRecord,
        Invitations::AcceptInvitation::PrepareParams,
        Invitations::CheckInviteeExistence,
        Invitations::SaveRecord,
        Invitations::AcceptInvitation::PrepareUserParams,
        Users::SaveRecord,
        Invitations::AcceptInvitation::PrepareMembershipParams,
        Memberships::SaveRecord
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
