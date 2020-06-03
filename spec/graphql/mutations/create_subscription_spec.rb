# frozen_string_literal: true

require "rails_helper"

describe Mutations::CreateSubscription do
  let(:query) do
    <<-GRAPHQL
      mutation {
        createSubscription(
          input: {
            stripeToken: "test_stripe_card_token",
            stripePriceToken: "test_stripe_price_token"
          }
        ) {
          subscription {
            status
          }
        }
      }
    GRAPHQL
  end

  let(:user) { create :user, email: "user@example.com" }

  before do
    allow(Stripe::Customer)
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
