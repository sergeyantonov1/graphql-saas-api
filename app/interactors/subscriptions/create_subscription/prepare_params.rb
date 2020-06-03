# frozen_string_literal: true

module Subscriptions
  module CreateSubscription
    class PrepareParams
      include Interactor

      delegate :user, :stripe_subscription, to: :context
      delegate :id, :status, to: :stripe_subscription, prefix: true
      delegate :id, to: :user, prefix: true

      def call
        context.subscription_params = subscription_params
      end

      private

      def subscription_params
        {
          user_id: user_id,
          status: status
        }
      end

      def status
        "active"
      end
    end
  end
end
