# frozen_string_literal: true

module Users
  class Authenticate
    include Interactor

    delegate :email, :password, :user, to: :context

    def call
      context.user = find_user

      context.fail!(error: error_message) unless authenticated?
    end

    private

    def authenticated?
      user.present? && user.valid_password?(password)
    end

    def find_user
      User.find_by(email: email)
    end

    def error_message
      I18n.t("errors.messages.invalid_credentials")
    end
  end
end
