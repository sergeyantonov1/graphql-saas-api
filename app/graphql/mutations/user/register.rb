# frozen_string_literal: true

module Mutations
  module User
    class Register < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      type Types::TokenType

      def resolve(**params)
        result = register_user(params)

        result.success? ? result : execution_error(message: result.error)
      end

      private

      def register_user(params)
        Users::Register.call(user: build_user, user_params: params)
      end

      def build_user
        ::User.new
      end
    end
  end
end
