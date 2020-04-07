# frozen_string_literal: true

module Users
  class Login
    include Interactor::Organizer
    include TransactionalInteractor

    organize Users::Authenticate,
      Users::GenerateToken
  end
end
