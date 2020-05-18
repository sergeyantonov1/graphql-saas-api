# frozen_string_literal: true

module AuthorizableResource
  extend ActiveSupport::Concern

  private

  def authorized?(*)
    true
  end

  def access_denied_error
    GraphQL::ExecutionError.new("Access denied", options: { status: :unauthorized, code: 401 })
  end
end
