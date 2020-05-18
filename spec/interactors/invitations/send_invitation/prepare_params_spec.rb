# frozen_string_literal: true

require "rails_helper"

describe Invitations::SendInvitation::PrepareParams do
  include_context :interactor

  let(:initial_context) do
    {
      email: email,
      invitee: invitee,
      company: company,
      sender: sender,
      token: token
    }
  end

  let(:email) { "user@example.com" }
  let(:invitee) { create :user, email: "user@example.com" }
  let(:sender) { create :user }
  let(:company) { create :company }
  let(:token) { "some_token" }

  let(:expected_invitation_params) do
    {
      email: "user@example.com",
      invitee: invitee,
      company: company,
      sender: sender,
      token: "some_token"
    }
  end

  describe ".call" do
    it "prepares params" do
      interactor.run

      expect(context.invitation_params).to eq(expected_invitation_params)
    end
  end
end
