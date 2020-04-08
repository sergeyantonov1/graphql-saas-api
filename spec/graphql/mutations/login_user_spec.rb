# frozen_string_literal: true

require "rails_helper"

describe Mutations::LoginUser do
  let(:query) do
    <<-GRAPHQL
      mutation {
        loginUser(
          input: {
            email: "#{email}",
            password: "password"
          }
        ) {
          token
          user {
            email
          }
        }
      }
    GRAPHQL
  end

  before do
    allow(JWT).to receive(:encode).and_return("some_token")

    create :user, email: "user@example.com", password: "password"
  end

  context "when valid credentials" do
    let(:email) { "user@example.com" }

    it_behaves_like :graphql_request, "login user" do
      let(:fixture_path) { "json/graphql/mutations/login_user_with_valid_credentials.json" }
    end
  end

  context "when invalid credentials" do
    let(:email) { "some_user@example.com" }

    it_behaves_like :graphql_request, "login user" do
      let(:fixture_path) { "json/graphql/mutations/login_user_with_invalid_credentials.json" }
    end
  end
end
