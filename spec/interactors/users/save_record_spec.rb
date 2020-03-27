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

  let(:saved_user) { User.last }

  context "when new user" do
    let(:user) { build :user }

    it "creates user" do
      expect { executed_context }.to change(User, :count).by(1)

      expect(saved_user.email).to eq("user@example.com")
    end
  end

  context "when existed user" do
    let!(:user) { create :user }

    it "updates user" do
      expect { executed_context }.not_to change(User, :count)

      expect(saved_user.email).to eq("user@example.com")
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
