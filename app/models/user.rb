# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Whitelist

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships

  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create
end
