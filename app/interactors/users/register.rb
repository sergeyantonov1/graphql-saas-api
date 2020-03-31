# frozen_string_literal: true

module Users
  class Register
    include Interactor::Organizer
    include TransactionalInteractor

    organize Users::SaveRecord,
      Users::GenerateToken,
      Users::SaveToken
  end
end
