# frozen_string_literal: true

require "rails_helper"

describe Mutations::SendInvitation do
  let(:query) do
    <<-GRAPHQL
      mutation {
        acceptInvitation(
          input: {
            token: "#{token}"
          }
        ) {
          membership {
            role
            company {
              name
            }
            user {
              email
            }
          }
        }
      }
    GRAPHQL
  end

  let!(:invitation) { create :invitation, email: email, token: "some_token", company: company, invitee: invitee }
  let(:email) { "user@example.com" }
  let(:token) { "some_token" }
  let(:company) { create :company, name: "Flatstack" }
  let(:invitee) { create :user, email: email }
  let(:user_params) { {} }

  it_behaves_like :graphql_request, "accept invitation" do
    let(:fixture_path) { "json/graphql/mutations/accept_invitation.json" }
  end

  context "when user already invited to company" do
    before do
      create :membership, company: company, user: invitee
    end

    it_behaves_like :graphql_request, "accept invitation" do
      let(:fixture_path) { "json/graphql/mutations/accept_invitation_by_invited_user.json" }
    end
  end

  context "when invitee does not exist" do
    let(:query) do
      <<-GRAPHQL
        mutation {
          acceptInvitation(
            input: {
              token: "#{token}",
              userParams: {
                password: "password",
                passwordConfirmation: "password"
              }
            }
          ) {
            membership {
              role
              company {
                name
              }
              user {
                email
              }
            }
          }
        }
      GRAPHQL
    end

    let(:invitee) { nil }

    it_behaves_like :graphql_request, "accept invitation" do
      let(:fixture_path) { "json/graphql/mutations/accept_invitation.json" }
    end
  end
end
