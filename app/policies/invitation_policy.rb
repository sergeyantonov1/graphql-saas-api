# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  authorize :company, allow_nil: true

  delegate :id, to: :company, prefix: true, allow_nil: true

  def create?
    user.own_companies.exists?(company_id)
  end
end
