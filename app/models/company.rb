# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
