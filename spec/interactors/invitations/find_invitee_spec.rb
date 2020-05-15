# frozen_string_literal: true

require "rails_helper"

describe Invitations::FindInvitee do
  include_context :interactor

  let(:initial_context) do
    {
      email: "user@example.com"
    }
  end

  let(:email) { "user@example.com" }

  describe ".call" do
    it "does not find invitee" do
      interactor.run

      expect(context.invitee).to be_nil
    end

    context "when invitee registered" do
      let!(:user) { create :user, email: "user@example.com" }

      it "finds invitee" do
        interactor.run

        expect(context.invitee).to eq(user)
      end
    end
  end
end
