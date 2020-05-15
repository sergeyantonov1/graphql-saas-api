# frozen_string_literal: true

module Mutations
  class SendInvitation < BaseMutation
    include AuthenticableApiUser
    include AuthorizableResource

    argument :email, String, required: true
    argument :company_id, Integer, required: true

    type Types::Payloads::SendInvitationType

    def authorized?(**params)
      return true if current_user.own_companies.exists?(params[:company_id])

      raise access_denied_error
    end

    def resolve(**params)
      @params = params

      send_invitation.success? ? send_invitation : execution_error(message: send_invitation.error)
    end

    private

    attr_reader :params

    def send_invitation
      @send_invitation ||= Invitations::Send.call(
        email: params[:email],
        company: company,
        sender: current_user
      )
    end

    def company
      current_user.own_companies.find(params[:company_id])
    end
  end
end
