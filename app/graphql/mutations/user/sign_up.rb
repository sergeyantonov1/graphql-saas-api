# frozen_string_literal: true

module Mutations
  module User
    class SignUp < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      type Types::UserType

      def resolve(email:, password:)
        ::User.create!(email: email, password: password)
      end
    end
  end
end
