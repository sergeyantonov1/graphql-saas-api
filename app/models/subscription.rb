# frozen_string_literal: true

class Subscription < ApplicationRecord
  extend Enumerize

  AVAILABLE_STATUSES = %i(active inactive).freeze

  enumerize :status, in: AVAILABLE_STATUSES, predicates: true, scope: :shallow

  belongs_to :user

  validates :user, :status, presence: true
end
