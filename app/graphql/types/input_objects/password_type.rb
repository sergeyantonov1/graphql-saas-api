# frozen_string_literal: true

module Types
  module InputObjects
    class PasswordType < Types::BaseInputObject
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end
