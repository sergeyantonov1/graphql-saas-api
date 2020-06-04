# frozen_string_literal: true

module StripeHandlers
  class HandleSubscriptionCreatedEvent
    include Interactor

    delegate :event, to: :context
    delegate :id, :status, :metadata, to: :stripe_subscription, prefix: true

    def call
      activate_subscription! if active_stripe_subscription?
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
    rescue
    end

    private

    def activate_subscription!
      subscription.update!(activate_subscription_params)
    end

    def activate_subscription_params
      {
        status: :paid,
        stripe_subscription_id: stripe_subscription_id
      }
    end

    def active_stripe_subscription?
      stripe_subscription_status == "active"
    end

    def subscription
      @subscription ||= Subscription.find(stripe_subscription_metadata.subscription_id)
    end

    def stripe_subscription
      @stripe_subscription ||= event.data.object
    end
  end
end
