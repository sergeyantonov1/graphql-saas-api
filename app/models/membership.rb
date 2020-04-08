# frozen_string_literal: true

class Membership < ApplicationRecord
  extend Enumerize

  AVAILABLE_ROLES = %i(owner member).freeze

  enumerize :role, in: AVAILABLE_ROLES, default: :member, predicates: true, scope: :shallow

  belongs_to :user
  belongs_to :company

  validates :user, :company, :role, presence: true
  validates :user, uniqueness: { scope: :company }
end
