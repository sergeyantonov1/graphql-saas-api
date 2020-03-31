# frozen_string_literal: true

require "rails_helper"

describe Users::GenerateToken do
  include_context :interactor
  include_context :time_is_frozen

  let(:initial_context) do
    {
      user: user
    }
  end

  let(:user) { create :user, id: 123_123 }

  let(:expected_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyMzEyM"\
      "ywianRpIjoiZjg4NjQwNjMzOTg2YjlkMmRmM2Jj"\
      "ZmI3NDU5MjNjZWMiLCJpYXQiOjE1NjE0MDI4MDA"\
      "sImV4cCI6MTU2MTQ4OTIwMH0.oDpKtHw6KJAvlh"\
      "RjaIREAARCE1KS13b3X3gyooZAegk"
  end
  let(:expected_payload) do
    {
      sub: 123_123,
      jti: "f88640633986b9d2df3bcfb745923cec",
      iat: 1561402800,
      exp: 1561489200
    }
  end

  let(:expected_context_params) do
    {
      token: expected_token,
      payload: expected_payload
    }
  end

  it { expect(executed_context).to eq(expected_context) }
end
