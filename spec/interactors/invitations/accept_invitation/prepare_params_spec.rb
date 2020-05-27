# frozen_string_literal: true

require "rails_helper"

describe Invitations::AcceptInvitation::PrepareParams do
  include_context :interactor
  include_context :time_is_frozen

  let(:initial_context) do
    {
      invitation: invitation
    }
  end

  let(:invitation) { create :invitation, email: email, company: company }
  let(:company) { create :company }
  let(:email) { "user@example.com" }

  let(:expected_context_params) do
    {
      email: "user@example.com",
      company: company,
      accepted_at: current_time
    }
  end

  describe ".call" do
    it "prepares params" do
      interactor.run

      expect(expected_context).to eq(expected_context)
    end
  end
end
