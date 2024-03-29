# frozen_string_literal: true

module Users
  class SaveRecord
    include Interactor

    delegate :user, :user_params, to: :context

    def call
      return if user_params.blank?

      context.user ||= build_user

      context.fail!(error: error_message) unless save_user
    end

    private

    def save_user
      user.update(user_params)
    end

    def build_user
      User.new
    end

    def error_message
      user.errors.full_messages.join(", ")
    end
  end
end
