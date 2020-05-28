# frozen_string_literal: true

require "rails_helper"

describe Invitations::AcceptInvitation::PrepareMembershipParams do
  include_context :interactor

  let(:initial_context) do
    {
      invitation: invitation,
      user: user
    }
  end

  let(:invitation) { create :invitation, company: company, invitee: user }

  let(:company) { create :company }
  let(:user) { create :user }

  let(:expected_membership_params) do
    {
      company_id: company.id,
      user_id: user.id,
      role: :member
    }
  end

  describe ".call" do
    it "prepares params" do
      interactor.run

      expect(context.membership_params).to eq(expected_membership_params)
    end
  end
end
