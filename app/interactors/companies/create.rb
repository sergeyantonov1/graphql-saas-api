# frozen_string_literal: true

module Companies
  class Create
    include Interactor::Organizer
    include TransactionalInteractor

    organize Companies::SaveRecord,
      Companies::CreateCompany::PrepareMembershipParams,
      Memberships::SaveRecord,
      Subscriptions::CreateSubscription::PrepareParams,
      Subscriptions::SaveRecord
  end
end
