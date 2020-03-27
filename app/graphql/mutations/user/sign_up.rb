# frozen_string_literal: true

module Mutations
  module User
    class SignUp < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      type Types::UserType

      def resolve(**params)
        result = register_user(params)

        if result.success?
          result.user
        else
          execution_error(message: result.error)
        end
      end

      private

      def execution_error(message: nil, status: 422, code: :unprocessable_entity)
        GraphQL::ExecutionError.new(message, options: { status: status, code: code })
      end

      def register_user(params)
        Users::Register.call(user: build_user, user_params: params)
      end

      def build_user
        ::User.new
      end
    end
  end
end
