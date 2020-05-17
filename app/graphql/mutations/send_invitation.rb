# frozen_string_literal: true

module Mutations
  class SendInvitation < BaseMutation
    include AuthenticableApiUser
    include AuthorizableResource

    argument :email, String, required: true
    argument :company_id, ID, required: true, loads: Types::CompanyType

    type Types::Payloads::SendInvitationType

    def authorized?(**params)
      return true if current_user.own_companies.exists?(params[:company].id)

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
        company: params[:company],
        sender: current_user
      )
    end
  end
end
