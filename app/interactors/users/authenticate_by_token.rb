# frozen_string_literal: true

module Users
  class AuthenticateByToken
    include Interactor

    delegate :auth_token, to: :context

    UNATHORIZED_ERROR = "Unauthorized error"

    def call
      context.current_user = current_user!
    rescue StandardError
      context.fail!(error: UNATHORIZED_ERROR)
    end

    private

    def current_user!
      User.find(decoded_token[0]["sub"])
    end

    def decoded_token
      JWT.decode(auth_token, hmac_secret, true, decode_options)
    end

    def decode_options
      {
        algorithm: ENV["HMAC_ALGORITHM"],
        verify_jti: true
      }
    end

    def hmac_secret
      ENV["HMAC_SECRET"]
    end

    def hmac_algorithm
      ENV["HMAC_ALGORITHM"]
    end
  end
end
