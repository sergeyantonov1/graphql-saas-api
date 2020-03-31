# frozen_string_literal: true

module ExecutionErrorResponder
  extend ActiveSupport::Concern

  private

  def execution_error(message: nil, status: 422, code: :unprocessable_entity)
    GraphQL::ExecutionError.new(message, options: { status: status, code: code })
  end
end
