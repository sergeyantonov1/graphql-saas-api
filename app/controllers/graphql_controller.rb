class GraphqlController < ApplicationController
  def execute
    render json: GraphqlSaasApiSchema.execute(query, schema_options)
  rescue => e
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

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
