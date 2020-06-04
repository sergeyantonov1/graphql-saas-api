# frozen_string_literal: true

require "rails_helper"

describe Subscriptions::CreateSubscription::PrepareParams do
  include_context :interactor

  let(:initial_context) do
    {
      user: user
    }
  end

  let(:user) { create :user }

  let(:expected_subscription_params) do
    {
      status: :free,
      user_id: user.id
    }
  end

  it "prepares params" do
    interactor.run

    expect(context.subscription_params).to eq(expected_subscription_params)
  end
end
