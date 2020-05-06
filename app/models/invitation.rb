# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :invitee, polymorphic: true, optional: true
  belongs_to :sender, polymorphic: true
  belongs_to :company

  validates :email, :token, :company, :sender, presence: true
end
