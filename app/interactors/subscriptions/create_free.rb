# frozen_string_literal: true

module Subscriptions
  class CreateFree
    include Interactor::Organizer

    organize Subscriptions::CreateFreeSubscription::PrepareParams,
      Subscriptions::SaveRecord
  end
end
