# frozen_string_literal: true

module Subscriptions
  module CreateFreeSubscription
    class PrepareParams
      include Interactor

      delegate :user, to: :context
      delegate :id, to: :user, prefix: true

      def call
        context.subscription_params = subscription_params
      end

      private

      def subscription_params
        {
          user_id: user_id,
          status: :inactive
        }
      end
    end
  end
end
