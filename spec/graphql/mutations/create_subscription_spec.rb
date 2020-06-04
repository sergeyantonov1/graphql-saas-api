# frozen_string_literal: true

require "rails_helper"

describe Mutations::CreateSubscription do
  let(:query) do
    <<-GRAPHQL
      mutation {
        createSubscription(
          input: {
            stripeToken: "#{stripe_token}",
            stripePriceToken: "#{stripe_price_token}"
          }
        ) {
          subscription {
            status
          }
        }
      }
    GRAPHQL
  end

  let(:user) { create :user, email: "user@example.com", stripe_customer_id: nil, subscription: subscription }
  let(:subscription) { create :subscription, stripe_subscription_id: nil, status: :free }

  let(:stripe_token) { "tok_visa" }
  let(:stripe_price_token) { "price_123" }

  let(:stripe_customer_resource) { double id: "cus_123" }
  let(:stripe_subscription_params) do
    {
      customer: "cus_123",
      items: [
        {
          price: "price_123"
        }
      ],
      metadata: {
        subscription_id: subscription.id
      }
    }
  end

  before do
    allow(Stripe::Customer).to receive(:create).with(email: "user@example.com").and_return(stripe_customer_resource)
    allow(Stripe::Customer).to receive(:update).with(stripe_customer_resource.id, source: stripe_token)
    allow(Stripe::Subscription).to receive(:create).with(stripe_subscription_params)
  end

  context "when authenticated user" do
    it_behaves_like :graphql_request, "create company" do
      let(:schema_context) { { current_user: user } }
      let(:fixture_path) { "json/graphql/mutations/create_subscription.json" }
    end
  end

  context "when not authenticated user" do
    it_behaves_like :graphql_request, "create subscription" do
      let(:fixture_path) { "json/graphql/mutations/create_subscription_by_not_authenticated_user.json" }
    end
  end
end
