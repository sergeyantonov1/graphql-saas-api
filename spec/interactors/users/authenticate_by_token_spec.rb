# frozen_string_literal: true

require "rails_helper"

describe Users::AuthenticateByToken do
  include_context :interactor

  let(:initial_context) do
    {
      auth_token: auth_token
    }
  end

  let!(:user) { create :user, id: 123_123 }
  let(:auth_token) { "some_auth_token" }

  context "when JWT token is valid" do
    let(:decoded_token) { [{ "sub" => "123123" }] }

    let(:expected_context_params) do
      {
        current_user: user
      }
    end

    before do
      allow(JWT).to receive(:decode).and_return(decoded_token)
    end

    it { expect(executed_context).to eq(expected_context) }
  end

  context "when JWT token is invalid" do
    let(:decode_error) { "Decode error" }

    let(:error_message) { "Decode error" }

    before do
      allow(JWT).to receive(:decode).and_raise(decode_error)
    end

    it_behaves_like :failed_interactor
  end
end
