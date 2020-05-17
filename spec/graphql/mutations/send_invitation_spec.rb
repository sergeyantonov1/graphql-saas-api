# frozen_string_literal: true

require "rails_helper"

describe Mutations::SendInvitation do
  let(:query) do
    <<-GRAPHQL
      mutation {
        sendInvitation(
          input: {
            email: "user@example.com",
            companyId: "#{company_global_id}"
          }
        ) {
          token
          email
        }
      }
    GRAPHQL
  end

  let(:current_user) { create :user }
  let(:company) { create :company, id: 123_123, name: "Flatstack" }
  let(:company_global_id) { company.to_global_id.to_s }

  before do
    allow(Digest::MD5).to receive(:hexdigest).and_return("some_token")
  end

  context "when authenticated user" do
    it_behaves_like :graphql_request, "send invitation" do
      let(:schema_context) { { current_user: current_user } }
      let(:fixture_path) { "json/graphql/mutations/send_invitation_to_not_accessible_company.json" }
    end

    context "when current user has permissions" do
      before do
        create :membership, company: company, user: current_user, role: :owner
      end

      it_behaves_like :graphql_request, "send invitation" do
        let(:schema_context) { { current_user: current_user } }
        let(:fixture_path) { "json/graphql/mutations/send_invitation.json" }
      end

      context "when user already invited" do
        let(:user) { create :user, email: "user@example.com" }

        before do
          create :membership, company: company, user: user, role: :member
        end

        it_behaves_like :graphql_request, "send invitation" do
          let(:schema_context) { { current_user: current_user } }
          let(:fixture_path) { "json/graphql/mutations/send_invitation_to_invited_user.json" }
        end
      end
    end
  end

  context "when not authenticated user" do
    it_behaves_like :graphql_request, "send invitation" do
      let(:fixture_path) { "json/graphql/mutations/send_invitation_by_not_authenticated_user.json" }
    end
  end
end
