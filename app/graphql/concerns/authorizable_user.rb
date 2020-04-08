# frozen_string_literal: true

module AuthorizableUser
  extend ActiveSupport::Concern

  private

  def ready?(*)
    return true if current_user

    raise unauthorized_error
  end

  def unauthorized_error
    GraphQL::ExecutionError.new("Unauthorized error", options: { status: :unauthorized, code: 401 })
  end

  def current_user
    @current_user ||= context[:current_user]
  end
end
