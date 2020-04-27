# frozen_string_literal: true

require "rails_helper"

describe Users::Authenticate do
  include_context :interactor

  let(:initial_context) do
    {
      email: email,
      password: password
    }
  end

  let!(:user) { create :user, email: "user@example.com", password: "password" }
  let(:password) { "password" }

  describe ".call" do
    context "when valid credentials" do
      let(:email) { "user@example.com" }

      let(:expected_context_params) do
        {
          user: user
        }
      end

      it { expect(executed_context).to eq(expected_context) }
    end

    context "when invalid credentials" do
      let(:email) { "some_user@example.com" }

      let(:error_message) { "Invalid credentials" }

      it_behaves_like :failed_interactor
    end
  end
end
