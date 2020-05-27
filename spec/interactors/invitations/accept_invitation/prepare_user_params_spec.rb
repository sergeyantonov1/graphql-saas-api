# frozen_string_literal: true

require "rails_helper"

describe Invitations::AcceptInvitation::PrepareUserParams do
  include_context :interactor

  let(:initial_context) do
    {
      user_params: user_params,
      invitation: invitation
    }
  end

  let(:user_params) { nil }
  let(:invitation) { create :invitation, invitee: invitee, email: email }

  let(:invitee) { create :user, email: "user@example.com" }
  let(:email) { "user@example.com" }

  describe ".call" do
    it "prepares params" do
      interactor.run

      expect(context.user).to eq(invitee)
      expect(context.user_params).to be_nil
    end

    context "when invitee is new user" do
      let(:invitee) { nil }
      let(:user_params) do
        {
          password: "password",
          password_confirmation: "password"
        }
      end

      let(:expected_user_params) do
        {
          password: "password",
          password_confirmation: "password",
          email: "user@example.com"
        }
      end

      it "prepares params" do
        interactor.run

        expect(context.user).to be_new_record
        expect(context.user_params).to eq(expected_user_params)
      end
    end
  end
end
