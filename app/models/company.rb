# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :user

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
end
