# frozen_string_literal: true

require "rails_helper"

describe Users::GenerateToken do
  include_context :interactor
  include_context :time_is_frozen

  let(:initial_context) { { user: user } }

  let(:user) { create :user, id: 123_123 }

  let(:expected_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEyMzEyM"\
      "ywianRpIjoiZjg4NjQwNjMzOTg2YjlkMmRmM2Jj"\
      "ZmI3NDU5MjNjZWMiLCJpYXQiOjE1NjE0MDI4MDA"\
      "sImV4cCI6MTU2MTQ4OTIwMH0.oDpKtHw6KJAvlh"\
      "RjaIREAARCE1KS13b3X3gyooZAegk"
  end

  it "generates token" do
    interactor.run

    expect(context.token).to eq(expected_token)
  end
end
