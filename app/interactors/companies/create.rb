# frozen_string_literal: true

module Companies
  class Create
    include Interactor::Organizer
    include TransactionalInteractor

    organize Companies::SaveRecord,
      Memberships::PrepareOwnerParams,
      Memberships::SaveRecord
  end
end
