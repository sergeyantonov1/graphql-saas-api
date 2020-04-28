# frozen_string_literal: true

module Mutations
  class AcceptInvitation < BaseMutation
    argument :token, String, required: true
    argument :user_params, Types::InputObjects::PasswordType, required: false

    type Types::Payloads::LoginUserType

    def resolve(**params)
      result = accept_invitation(params)

      result.success? ? result : execution_error(message: result.error)
    end

    private

    def accept_invitation(params)
      AcceptIntitation.call(
        token: params[:token],
        user_params: params[:user_params]
      )
    end
  end
end
