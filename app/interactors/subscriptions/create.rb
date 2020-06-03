# frozen_string_literal: true

module Subscriptions
  class Create
    include Interactor::Organizer

    organize StripeResources::FindOrCreateCustomer,
      Subscriptions::CreateSubscription::PrepareUserParams,
      Users::SaveRecord,
      StripeResources::AttachCard,
      Subscriptions::CreateSubscription::PrepareParams,
      Subscriptions::SaveRecord,
      StripeResources::CreateSubscription

  end
end
