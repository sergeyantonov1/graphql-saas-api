# frozen_string_literal: true

require "rails_helper"

describe Invitations::GenerateToken do
  include_context :interactor
  include_context :time_is_frozen

  let(:initial_context) do
    {
      email: email
    }
  end

  let(:email) { "user@example.com" }

  let(:expected_token) { "8f47c53c1ac3420125a0747648f409bf" }

  it "generates invite token" do
    interactor.run

    expect(context.token).to eq(expected_token)
  end
end
