# frozen_string_literal: true

require "rails_helper"

describe Invitations::FindRecord do
  include_context :interactor

  let(:initial_context) do
    {
      token: token
    }
  end

  let(:token) { "some_token" }

  let!(:invitation) { create :invitation, token: "some_token", accepted_at: accepted_at }
  let(:accepted_at) { nil }

  describe ".call" do
    it "finds invitation by token" do
      interactor.run

      expect(context.invitation).to eq(invitation)
    end

    context "when invitation accepted" do
      let(:accepted_at) { 1.day.ago }

      let(:error_message) { "Invitation not found or accessible" }

      it_behaves_like :failed_interactor
    end

    context "when invalid token" do
      let(:token) { "some_token_2" }

      let(:error_message) { "Invitation not found or accessible" }

      it_behaves_like :failed_interactor
    end
  end
end
