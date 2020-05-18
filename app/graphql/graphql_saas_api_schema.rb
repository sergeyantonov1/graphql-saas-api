# frozen_string_literal: true

class GraphqlSaasApiSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use GraphQL::Execution::Errors

  rescue_from ActiveRecord::RecordNotFound do |exception|
    model_name = exception.message.match(/Couldn't find ([\w]+)/).to_a.last.titleize

    error_message = I18n.t("errors.messages.record_not_found", model_name: model_name)

    GraphQL::ExecutionError.new(error_message, options: { status: :record_not_found, code: 404 })
  end

  def self.id_from_object(object, _type, _context)
    object.to_global_id.to_s
  end

  def self.object_from_id(global_id, _context)
    GlobalID::Locator.locate(global_id)
  end
end
