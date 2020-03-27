# frozen_string_literal: true

module Mutations
  module User
    class SignUp < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      type Types::UserType

      def resolve(**params)
        # create user
        # generate JWT token
        # return token to user
        # ::User.create!(email: email, password: password)
      end

      private

      def sanitize_params

      end
    end
  end
end
