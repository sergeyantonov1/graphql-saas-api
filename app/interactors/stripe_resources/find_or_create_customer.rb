# frozen_string_literal: true

module StripeResources
  class FindOrCreateCustomer
    include Interactor

    delegate :user, to: :context
    delegate :stripe_customer_id, :email, to: :user, prefix: true

    def call
      context.stripe_customer = find_or_create_customer
    rescue Stripe::StripeError => e
      context.fail!(error: e.message)
    end

    private

    def find_or_create_customer
      retrieve_customer.presence || create_stripe_customer
    end

    def create_stripe_customer
      Stripe::Customer.create(email: user_email)
    end

    def retrieve_customer
      Stripe::Customer.retrieve(user_stripe_customer_id) if user_stripe_customer_id.present?
    end
  end
end
