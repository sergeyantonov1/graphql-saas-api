# frozen_string_literal: true

require "rails_helper"

describe Memberships::SaveRecord do
  include_context :interactor

  let(:initial_context) do
    {
      membership: membership,
      membership_params: membership_params
    }
  end

  let(:company) { create :company }
  let(:user) { create :user }
  let(:membership_params) do
    {
      company_id: company.id,
      user_id: user.id,
      role: :owner
    }
  end

  describe ".call" do
    context "when new membership" do
      let(:membership) { build :membership }

      let(:expected_attributes) do
        {
          company_id: company.id,
          user_id: user.id,
          role: "owner"
        }
      end

      it "creates membership" do
        expect { executed_context }.to change(Membership, :count).by(1)

        expect(Membership.last).to have_attributes(expected_attributes)
      end
    end

    context "when existed membership" do
      let!(:membership) { create :membership, company: company, user: user, role: :member }

      let(:expected_attributes) do
        {
          company_id: company.id,
          user_id: user.id,
          role: "owner"
        }
      end

      it "updates membership" do
        expect { executed_context }.not_to change(Membership, :count)

        expect(Membership.last).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:membership) { build :membership }
      let(:membership_params) do
        {
          user_id: 123_123,
          company_id: 123_123,
          role: nil
        }
      end

      let(:error_message) do
        "User must exist, User can't be blank, Company must exist, Company can't be blank, Role can't be blank"
      end

      it_behaves_like :failed_interactor
    end
  end
end
