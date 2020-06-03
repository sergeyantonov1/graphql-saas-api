# frozen_string_literal: true

require "rails_helper"

describe Subscriptions::SaveRecord do
  include_context :interactor

  let(:initial_context) do
    {
      subscription: subscription,
      subscription_params: subscription_params
    }
  end

  let(:subscription) { nil }
  let(:subscription_params) do
    {
      status: :inactive,
      user_id: user.id,
      stripe_subscription_id: "sub_123"
    }
  end

  let(:company) { create :company }
  let(:user) { create :user }

  let(:expected_attributes) do
    {
      status: "inactive",
      user_id: user.id,
      stripe_subscription_id: "sub_123"
    }
  end

  describe ".call" do
    it "creates subscription" do
      expect { interactor.run }.to change(Subscription, :count).by(1)

      expect(context.subscription).to have_attributes(expected_attributes)
    end

    context "when subscription exists" do
      let!(:subscription) { create :subscription, status: :active, user: user, stripe_subscription_id: nil }

      it "updates subscription" do
        expect { interactor.run }.not_to change(Subscription, :count)

        expect(context.subscription).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:subscription_params) do
        {
          status: nil,
          user_id: 123_123,
          stripe_subscription_id: nil
        }
      end

      let(:error_message) do
        "User must exist, User can't be blank, Status can't be blank"
      end

      it_behaves_like :failed_interactor
    end
  end
end
