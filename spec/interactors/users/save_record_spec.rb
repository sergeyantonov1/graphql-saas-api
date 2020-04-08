# frozen_string_literal: true

require "rails_helper"

describe Users::SaveRecord do
  include_context :interactor

  let(:initial_context) do
    {
      user: user,
      user_params: user_params
    }
  end

  let(:user_params) do
    {
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  context "when new user" do
    let(:user) { build :user }

    let(:expected_attributes) do
      {
        email: "user@example.com"
      }
    end

    it "creates user" do
      expect { executed_context }.to change(User, :count).by(1)

      expect(User.last).to have_attributes(expected_attributes)
    end
  end

  context "when existed user" do
    let!(:user) { create :user }

    let(:expected_attributes) do
      {
        email: "user@example.com"
      }
    end

    it "updates user" do
      expect { executed_context }.not_to change(User, :count)

      expect(User.last).to have_attributes(expected_attributes)
    end
  end

  context "when invalid params" do
    let(:user) { build :user, email: nil }
    let(:user_params) do
      {
        password: "password",
        password_confirmation: "password"
      }
    end

    let(:error_message) { "Email can't be blank" }

    it_behaves_like :failed_interactor
  end
end
