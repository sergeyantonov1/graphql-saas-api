# frozen_string_literal: true

class Send
  include Interactor

  delegate :email, :company, :invited_by, to: :context

  def call
    # --- Invitation columns ---
    # invitee
    # invited_by
    # token
    # company
    # accepted_at

    invitation = Invitation.create(
      invited_by_id: invited_by.id,
      invited_by_type: invited_by.class.name,
      invitee_id: invitee.id,
      invitee_type: "User",
      token: token,
      company_id: company.id
    )

    InvitationMailer.send_invitation(invitation)
  end

  private

  def invitee
    User.find_by(email: email)
  end

  def token
    "some_token"
  end
end
