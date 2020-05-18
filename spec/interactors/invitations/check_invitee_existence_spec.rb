# frozen_string_literal: true

require "rails_helper"

describe Invitations::CheckInviteeExistence do
  include_context :interactor

  let(:initial_context) do
    {
      email: email,
      company: company
    }
  end

  let(:email) { "user@example.com" }
  let(:company) { create :company, name: "Flatstack" }

  describe ".call" do
    it "checks invitee existence" do
      interactor.run

      expect(context.success?).to be_truthy

      expect(context.invitee).to be_nil
    end

    context "when invitee is exist" do
      let!(:invitee) { create :user, email: "user@example.com" }

      it "checks invitee existence" do
        interactor.run

        expect(context.success?).to be_truthy

        expect(context.invitee).to eq(invitee)
      end

      context "when invitee already invited to company" do
        before do
          create :membership, company: company, user: invitee
        end

        let(:error_message) { "The user already invited to Flatstack" }

        it_behaves_like :failed_interactor
      end
    end
  end
end
