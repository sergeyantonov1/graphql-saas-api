# frozen_string_literal: true

module Users
  class GenerateToken
    include Interactor

    def call
      context.token = JWT.encode jti_payload, hmac_secret, 'HS256'
    end

    private

    def error_message
      user.errors.full_messages.join(", ")
    end
  end
end
