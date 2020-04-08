# frozen_string_literal: true

require "rails_helper"

describe Mutations::CreateCompany do
  let(:query) do
    <<-GRAPHQL
      mutation {
        createCompany(
          input: {
            name: "Company Name"
          }
        ) {
          company {
            name
            user {
              email
            }
          }
        }
      }
    GRAPHQL
  end

  let(:user) { create :user, email: "user@example.com" }

  context "when authenticated user" do
    it_behaves_like :graphql_request, "create company" do
      let(:schema_context) { { current_user: user } }
      let(:fixture_path) { "json/graphql/mutations/create_company_by_authenticated_user.json" }
    end
  end

  context "when not authenticated user" do
    it_behaves_like :graphql_request, "create company" do
      let(:fixture_path) { "json/graphql/mutations/create_company_by_not_authenticated_user.json" }
    end
  end
end
