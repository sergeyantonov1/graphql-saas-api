# frozen_string_literal: true

require "rails_helper"

describe StripeHandlers::HandleSubscriptionCreatedEvent, :stub_stripe do
  include_context :interactor

  let(:initial_context) do
    {
      event: event
    }
  end

  let(:event) do
    StripeMock.mock_webhook_event(
      "customer.subscription.created",
      id: "sub_123",
      metadata: metadata,
      status: status
    )
  end

  let(:status) { "active" }
  let(:metadata) do
    {
      "subscription_id" => subscription.id
    }
  end

  let(:subscription) { create :subscription, status: :free, stripe_subscription_id: nil }

  let(:expected_subscription_params) do
    {
      status: "paid",
      stripe_subscription_id: "sub_123"
    }
  end

  describe "#call" do
    it_behaves_like :success_interactor

    it "activates subscription" do
      interactor.run

      expect(subscription.reload).to have_attributes(expected_subscription_params)
    end

    context "when subscription status is not active" do
      let(:status) { "incomplete" }

      let(:expected_subscription_params) do
        {
          status: "free",
          stripe_subscription_id: nil
        }
      end

      it "does not activate subscription" do
        interactor.run

        expect(subscription.reload).to have_attributes(expected_subscription_params)
      end
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
