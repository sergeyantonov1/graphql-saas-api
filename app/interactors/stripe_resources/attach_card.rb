# frozen_string_literal: true

module StripeResources
  class AttachCard
    include Interactor

    delegate :stripe_customer, :stripe_token, to: :context
    delegate :id, to: :stripe_customer, prefix: true

    def call
      Stripe::Customer.update(stripe_customer_id, source: stripe_token)
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end
  end
end
