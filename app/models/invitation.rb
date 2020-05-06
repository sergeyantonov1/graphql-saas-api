# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :invitee, polymorphic: true
  belongs_to :invited_by, polymorphic: true
  belongs_to :company

  validates :email, :token, :company, :invited_by, presence: true
end
