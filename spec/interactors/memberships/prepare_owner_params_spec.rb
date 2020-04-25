# frozen_string_literal: true

require "rails_helper"

describe Memberships::PrepareOwnerParams do
  include_context :interactor

  let(:initial_context) do
    {
      company: company,
      user: user
    }
  end

  let(:company) { create :company }
  let(:user) { create :user }

  let(:expected_membership_params) do
    {
      role: :owner,
      user_id: user.id,
      company_id: company.id
    }
  end

  it "prepares params" do
    interactor.run

    expect(context.membership).to be_new_record
    expect(context.membership_params).to eq(expected_membership_params)
  end
end
