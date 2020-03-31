# frozen_string_literal: true

module Users
  class SaveToken
    include Interactor

    delegate :user, :token, :payload, to: :context

    WHITELISTED_JWT_ERROR_MESSAGE = "Could not save token"

    def call
      save_whitelisted_jwt!
    rescue
      context.fail!(error: WHITELISTED_JWT_ERROR_MESSAGE)
    end

    private

    def save_whitelisted_jwt!
      user.on_jwt_dispatch(token, payload.stringify_keys)
    end
  end
end

