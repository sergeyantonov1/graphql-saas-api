# frozen_string_literal: true

require "rails_helper"

describe Invitations::Send do
  describe ".organized" do
    let(:expected_interactors) do
      [
        Invitations::FindInvitee,
        Invitations::CheckInviteeExistence,
        Invitations::GenerateToken,
        Invitations::SendInvitation::PrepareParams,
        Invitations::SaveRecord,
        Invitations::SendInvitationEmail
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
