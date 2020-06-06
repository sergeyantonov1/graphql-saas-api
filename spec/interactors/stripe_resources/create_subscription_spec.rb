# frozen_string_literal: true

require "rails_helper"

describe StripeResources::CreateSubscription, :stub_stripe do
  include_context :interactor

  let(:initial_context) do
    {
      stripe_customer: stripe_customer,
      stripe_price_token: stripe_price_token,
      subscription: subscription
    }
  end

  let(:stripe_customer) { double id: "cus_123" }
  let(:stripe_price_token) { "price_123" }
  let(:subscription) { create :subscription }

  before do
    allow(Stripe::Subscription).to receive(:create)
  end

  describe "#call" do
    it_behaves_like :success_interactor

    it "creates subscription" do
      expect(Stripe::Subscription).to receive(:create)
        .with(
          customer: stripe_customer.id,
          items: [
            { price: stripe_price_token }
          ],
          metadata: {
            subscription_id: subscription.id
          }
        )

      interactor.run
    end

    context "with stripe error" do
      let(:stripe_error) { Stripe::StripeError.new("Error message") }

      let(:error) { "Error message" }

      before do
        allow(Stripe::Subscription).to receive(:create).and_raise(stripe_error)
      end

      it_behaves_like :failed_interactor
    end
  end
end
