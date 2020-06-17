# frozen_string_literal: true

module Subscriptions
  module CreateSubscription
    class PrepareUserParams
      include Interactor

      delegate :stripe_customer, to: :context
      delegate :id, to: :stripe_customer, prefix: true

      def call
        context.user_params = user_params
      end

      private

      def user_params
        { stripe_customer_id: stripe_customer_id }
      end
    end
  end
end
