# frozen_string_literal: true

module Users
  class AuthenticateByToken
    include Interactor

    delegate :auth_token, to: :context

    def call
      byebug
    end

    private

    def hmac_secret
      ENV["HMAC_SECRET"]
    end

    def hmac_algorithm
      ENV["HMAC_ALGORITHM"]
    end
  end
end
