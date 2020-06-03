# frozen_string_literal: true

module StripeResources
  class CreateSubscription
    include Interactor

    delegate :stripe_customer, :stripe_price_token, :subscription, to: :context
    delegate :id, to: :stripe_customer, prefix: true
    delegate :id, to: :subscription, prefix: true

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
        metadata: metadata
      )
    end

    def subscription_items
      [
        { price: stripe_price_token }
      ]
    end

    def metadata
      { subscription_id: subscription_id }
    end
  end
end
