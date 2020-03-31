# frozen_string_literal: true

require "rails_helper"

describe Users::SaveToken do
  include_context :interactor
  include_context :time_is_frozen

  let(:initial_context) do
    {
      user: user,
      token: token,
      payload: payload
    }
  end

  let(:user) { create :user, id: 123_123 }
  let(:token) { "some_token" }
  let(:payload) do
    {
      jti: "some_jwt_id",
      aud: "some_aud",
      exp: current_time.to_i
    }
  end

  let(:expected_whitelisted_jwt_attributes) do
    {
      user_id: 123_123,
      jti: "some_jwt_id",
      aud: "some_aud",
      exp: current_time
    }
  end

  it "saves token" do
    expect { interactor.run }.to change(WhitelistedJwt, :count).by(1)

    expect(WhitelistedJwt.last).to have_attributes(expected_whitelisted_jwt_attributes)
  end
end
