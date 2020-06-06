# frozen_string_literal: true

require "rails_helper"

describe StripeHandlers::HandleSubscriptionDeletedEvent, :stub_stripe do
  include_context :interactor

  let(:initial_context) do
    {
      event: event
    }
  end

  let(:event) do
    StripeMock.mock_webhook_event(
      "customer.subscription.deleted",
      id: "sub_123",
      metadata: metadata
    )
  end

  let(:metadata) do
    {
      "subscription_id" => subscription.id
    }
  end

  let(:subscription) { create :subscription, status: :paid, stripe_subscription_id: "sub_123" }

  let(:expected_subscription_params) do
    {
      status: "free",
      stripe_subscription_id: nil
    }
  end

  describe "#call" do
    it_behaves_like :success_interactor

    it "deactivates subscription" do
      interactor.run

      expect(subscription.reload).to have_attributes(expected_subscription_params)
    end

    context "when invalid subscription ID" do
      let(:metadata) do
        {
          "subscription_id" => 0
        }
      end

      let(:error_message) { "Couldn't find Subscription with 'id'=0" }

      it_behaves_like :failed_interactor
    end
  end
end
