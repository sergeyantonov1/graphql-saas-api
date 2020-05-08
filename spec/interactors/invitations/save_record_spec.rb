# frozen_string_literal: true

require "rails_helper"

describe Invitations::SaveRecord do
  include_context :interactor

  let(:initial_context) do
    {
      invitation: invitation,
      invitation_params: invitation_params
    }
  end

  let(:invitation) { nil }
  let(:invitation_params) do
    {
      email: email,
      company: company,
      invitee: invitee,
      sender: sender,
      token: token
    }
  end

  let(:email) { "user@example.com" }
  let(:company) { create :company }
  let(:invitee) { create :user, email: "user@example.com" }
  let(:sender) { create :user }
  let(:token) { "some_token" }

  let(:expected_attributes) do
    {
      email: "user@example.com",
      company: company,
      invitee: invitee,
      sender: sender,
      token: "some_token",
      accepted_at: nil
    }
  end

  describe ".call" do
    it "creates invitation" do
      expect { interactor.run }.to change(Invitation, :count).by(1)

      expect(context.invitation).to have_attributes(expected_attributes)
    end

    context "when invitation exists" do
      let!(:invitation) do
        create :invitation, email: email, company: company, invitee: invitee, sender: sender,
          token: "another_token", accepted_at: nil
      end

      it "updates invitation" do
        expect { interactor.run }.not_to change(Invitation, :count)

        expect(context.invitation).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:invitation_params) do
        {
          company: company,
          invitee: invitee,
          sender: sender,
          token: "some_token",
          accepted_at: nil
        }
      end

      let(:error_message) { "Email can't be blank, Email is invalid" }

      it_behaves_like :failed_interactor
    end
  end
end
