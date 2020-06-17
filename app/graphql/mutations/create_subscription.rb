# frozen_string_literal: true

module Mutations
  class CreateSubscription < BaseMutation
    include AuthenticableApiUser

    argument :stripe_token, String, required: true
    argument :stripe_price_token, String, required: true

    type Types::Payloads::CreateSubscriptionType

    def resolve(**params)
      result = create_subscription(params)

      result.success? ? result : execution_error(message: result.error)
    end

    private

    def create_subscription(params)
      Subscriptions::Create.call(
        stripe_token: params[:stripe_token],
        stripe_price_token: params[:stripe_price_token],
        user: current_user
      )
    end
  end
end
