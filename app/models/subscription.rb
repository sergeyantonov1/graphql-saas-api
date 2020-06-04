# frozen_string_literal: true

class Subscription < ApplicationRecord
  extend Enumerize

  AVAILABLE_STATUSES = %i(free paid).freeze

  enumerize :status, in: AVAILABLE_STATUSES, predicates: true, scope: :shallow, default: :free

  belongs_to :user

  validates :user, :status, presence: true
end
