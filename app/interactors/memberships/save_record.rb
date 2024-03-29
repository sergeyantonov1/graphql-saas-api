# frozen_string_literal: true

module Memberships
  class SaveRecord
    include Interactor

    delegate :membership, :membership_params, to: :context

    def call
      return if membership_params.blank?

      context.membership ||= build_membership

      context.fail!(error: error_message) unless save_membership
    end

    private

    def save_membership
      membership.update(membership_params)
    end

    def build_membership
      Membership.new
    end

    def error_message
      membership.errors.full_messages.join(", ")
    end
  end
end
