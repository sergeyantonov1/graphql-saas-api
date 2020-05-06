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

  let(:membership) { nil }
  let(:membership_params) do
    {
      company_id: company.id,
      user_id: user.id,
      role: :owner
    }
  end

  let(:company) { create :company }
  let(:user) { create :user }

  let(:expected_attributes) do
    {
      company_id: company.id,
      user_id: user.id,
      role: "owner"
    }
  end

  describe ".call" do
    it "creates membership" do
      expect { interactor.run }.to change(Membership, :count).by(1)

      expect(context.membership).to have_attributes(expected_attributes)
    end

    context "when membership exists" do
      let!(:membership) { create :membership, company: company, user: user, role: :member }

      it "updates membership" do
        expect { interactor.run }.not_to change(Membership, :count)

        expect(context.membership).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
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
