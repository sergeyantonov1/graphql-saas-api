# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :login_user, mutation: Mutations::LoginUser
    field :create_company, mutation: Mutations::CreateCompany
    field :send_invitation, mutation: Mutations::SendInvitation
    field :accept_invitation, mutation: Mutations::AcceptInvitation
  end
end
