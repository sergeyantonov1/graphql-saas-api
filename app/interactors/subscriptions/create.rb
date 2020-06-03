# frozen_string_literal: true

module Subscriptions
  class Create
    include Interactor::Organizer

    organize StripeResources::FindOrCreateCustomer,
      Subscriptions::CreateSubscription::PrepareUserParams,
      Users::SaveRecord,
      StripeResources::AttachCard,
      StripeResources::CreateSubscription,
      Subscriptions::CreateSubscription::PrepareParams,
      Subscriptions::SaveRecord
  end
end
