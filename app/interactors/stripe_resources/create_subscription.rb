# frozen_string_literal: true

module StripeResources
  class CreateSubscription
    include Interactor

    delegate :stripe_customer, :stripe_price_token, to: :context
    delegate :id, to: :stripe_customer, prefix: true

    def call
      context.stripe_subscription = create_subscription
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end

    private

    def create_subscription
      Stripe::Subscription.create(
        customer: stripe_customer_id,
        items: subscription_items,
        billing_cycle_anchor: 1.day.since.to_i
      )
    end

    def subscription_items
      [
        { price: stripe_price_token }
      ]
    end
  end
end
