module AuthenticableUser
  extend ActiveSupport::Concern
  include ExecutionErrorResponder

  private

  def ready?(*)
    GraphQL::ExecutionError.new("fd", options: { status: :unauthorized, code: 401 })
  end
end
