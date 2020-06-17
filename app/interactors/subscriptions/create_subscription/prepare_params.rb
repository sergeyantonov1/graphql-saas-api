# frozen_string_literal: true

module Subscriptions
  module CreateSubscription
    class PrepareParams
      include Interactor

      delegate :user, to: :context
      delegate :id, :subscription, to: :user, prefix: true

      def call
        context.subscription = user_subscription
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
        :free
      end
    end
  end
end
