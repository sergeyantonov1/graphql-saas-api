# frozen_string_literal: true

module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::Payloads::LoginUserType

    def resolve(email:, password:)
      result = login_user(email, password)

      result.success? ? result : execution_error(message: result.error)
    end

    private

    def login_user(email, password)
      Users::Login.call(email: email, password: password)
    end
  end
end
