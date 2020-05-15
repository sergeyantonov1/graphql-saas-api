# frozen_string_literal: true

require "rails_helper"

describe Invitations::CheckInviteeExistence do
  include_context :interactor

  let(:initial_context) do
    {
      invitee: invitee,
      company: company
    }
  end

  let(:invitee) { create :user }
  let(:company) { create :company, name: "Flatstack" }

  describe ".call" do
    it_behaves_like :success_interactor

    context "when user already invited to company" do
      before do
        create :membership, company: company, user: invitee
      end

      let(:error_message) { "The user already invited to Flatstack" }

      it_behaves_like :failed_interactor
    end
  end
end
