# frozen_string_literal: true

require "rails_helper"

describe Subscriptions::CreateSubscription::PrepareUserParams do
  include_context :interactor

  let(:initial_context) do
    {
      stripe_customer: stripe_customer
    }
  end

  let(:stripe_customer) { double id: "cus_123" }

  let(:expected_user_params) do
    {
      stripe_customer_id: "cus_123"
    }
  end

  it "prepares params" do
    interactor.run

    expect(context.user_params).to eq(expected_user_params)
  end
end
