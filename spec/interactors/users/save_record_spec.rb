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

  let(:user) { nil }
  let(:user_params) do
    {
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  let(:expected_attributes) do
    {
      email: "user@example.com"
    }
  end

  describe ".call" do
    it "creates user" do
      expect { interactor.run }.to change(User, :count).by(1)

      expect(context.user).to have_attributes(expected_attributes)
    end

    context "when user exists" do
      let!(:user) { create :user }

      it "updates user" do
        expect { interactor.run }.not_to change(User, :count)

        expect(context.user).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:user_params) do
        {
          email: nil,
          password: "password",
          password_confirmation: "password"
        }
      end

      let(:error_message) { "Email can't be blank" }

      it_behaves_like :failed_interactor
    end
  end
end
