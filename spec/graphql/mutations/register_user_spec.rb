# frozen_string_literal: true

require "rails_helper"

describe Mutations::RegisterUser do
  let(:query) do
    <<-GRAPHQL
      mutation {
        registerUser(
          input: {
            email: "user@example.com",
            password: "password",
            passwordConfirmation: "password"
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
  end

  it_behaves_like :graphql_request, "register user" do
    let(:fixture_path) { "json/graphql/mutations/register_user.json" }
  end
end
