# frozen_string_literal: true

module AuthenticableUser
  extend ActiveSupport::Concern

  private

  def ready?(**args)
    authenticate_user = Users::AuthenticateByToken.call(auth_token: args[:token])

    return context[:current_user] = authenticate_user.current_user if authenticate_user.success?

    raise GraphQL::ExecutionError.new(authenticate_user.error, options: { status: :unauthorized, code: 401 })
  end
end
