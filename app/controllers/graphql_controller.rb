# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    render json: GraphqlSaasApiSchema.execute(query, schema_options)
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def query
    params[:query]
  end

  def schema_options
    {
      variables: variables,
      context: context,
      operation_name: operation_name
    }
  end

  def variables
    ensure_hash(params[:variables])
  end

  def context
    {
      # current_user: current_user,
    }
  end

  def operation_name
    params[:operationName]
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters then ambiguous_param
    when nil then {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error error.message
    logger.error error.backtrace.join("\n")

    response_body = { error: { message: error.message, backtrace: error.backtrace }, data: {} }

    render json: response_body, status: 500
  end
end
