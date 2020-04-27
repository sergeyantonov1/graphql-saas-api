# frozen_string_literal: true

module Memberships
  class SaveRecord
    include Interactor

    delegate :membership, :membership_params, to: :context

    def call
      context.fail!(error: error_message) unless save_membership
    end

    private

    def save_membership
      membership.update(membership_params)
    end

    def error_message
      membership.errors.full_messages.join(", ")
    end
  end
end
