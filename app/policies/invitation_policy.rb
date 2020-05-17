# frozen_string_literal: true

class InvitationPolicy < ApplicationPolicy
  authorize :company, allow_nil: true

  def create?
    user.own_companies.exists?(company.id)
  end
end
