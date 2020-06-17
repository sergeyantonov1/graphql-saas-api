# frozen_string_literal: true

module StripeHandlers
  class HandleSubscriptionDeletedEvent
    include Interactor

    delegate :event, to: :context
    delegate :metadata, to: :stripe_subscription, prefix: true

    def call
      deactivate_subscription!
    rescue ActiveRecord::ActiveRecordError => e
      context.fail!(error: e.message)
    end

    private

    def deactivate_subscription!
      subscription.update!(deactivate_subscription_params)
    end

    def deactivate_subscription_params
      {
        status: :free,
        stripe_subscription_id: nil
      }
    end

    def subscription
      @subscription ||= Subscription.find(stripe_subscription_metadata.subscription_id)
    end

    def stripe_subscription
      @stripe_subscription ||= event.data.object
    end
  end
end
