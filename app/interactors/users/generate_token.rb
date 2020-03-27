# frozen_string_literal: true

module Users
  class GenerateToken
    include Interactor

    delegate :user, to: :context
    delegate :id, to: :user, prefix: true

    CRYPTOGRAPHIC_ALGORITHM = "HS256"

    def call
      context.token = generate_token
      context.payload = payload
    end

    private

    def generate_token
      JWT.encode(payload, hmac_secret, CRYPTOGRAPHIC_ALGORITHM)
    rescue => error
      context.fail!(error: error.message)
    end

    def payload
      @payload ||= { sub: user_id, jti: jwt_id, iat: issued_at, exp: expiration_time }
    end

    def hmac_secret
      ENV["DEVISE_JWT_SECRET_KEY"]
    end

    def jwt_id
      Digest::MD5.hexdigest(
        [hmac_secret, issued_at].join(":").to_s
      )
    end

    def issued_at
      @issued_at ||= Time.current.to_i
    end

    def expiration_time
      jwt_expiration_interval.day.since.to_i
    end

    def jwt_expiration_interval
      ENV.fetch("JWT_EXPIRATION_DAYS_INTERVAL", 1)
    end
  end
end
