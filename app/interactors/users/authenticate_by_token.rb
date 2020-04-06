# frozen_string_literal: true

module Users
  class AuthenticateByToken
    include Interactor

    delegate :auth_token, to: :context

    USER_NOT_FOUND_MESSAGE = "We could not authenticate the user"

    def call
      context.current_user = authenticate_user!
    end

    private

    def authenticate_user!
      User.find(decoded_token[0]["sub"])
    rescue ActiveRecord::RecordNotFound
      context.fail!(error: USER_NOT_FOUND_MESSAGE)
    end

    def decoded_token
      JWT.decode(auth_token, hmac_secret, true, decode_options)
    rescue StandardError => e
      context.fail!(error: e.message)
    end

    def decode_options
      @decoded_options ||= {
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
