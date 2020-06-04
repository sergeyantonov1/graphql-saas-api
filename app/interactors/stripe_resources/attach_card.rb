# frozen_string_literal: true

module StripeResources
  class AttachCard
    include Interactor

    delegate :stripe_customer, :stripe_token, to: :context
    delegate :id, to: :stripe_customer, prefix: true

    def call
      attach_card
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end

    private

    def attach_card
      Stripe::Customer.update(stripe_customer_id, source: stripe_token)
    end
  end
end
