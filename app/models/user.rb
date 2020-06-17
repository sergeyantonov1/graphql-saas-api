# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Whitelist

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :subscription

  has_many :memberships, dependent: :destroy
  has_many :companies, through: :memberships
  has_many :own_memberships, -> { owner }, class_name: "Membership"
  has_many :own_companies, through: :own_memberships, source: :company

  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create
  validates :stripe_customer_id, uniqueness: true, allow_blank: true
end
