# frozen_string_literal: true

module Subscriptions
  class SaveRecord
    include Interactor

    delegate :subscription, :subscription_params, to: :context

    def call
      return if subscription_params.blank?

      context.subscription ||= build_subscription

      context.fail!(error: error_message) unless save_subscription
    end

    private

    def save_subscription
      subscription.update(subscription_params)
    end

    def build_subscription
      Subscription.new
    end

    def error_message
      subscription.errors.full_messages.join(", ")
    end
  end
end
