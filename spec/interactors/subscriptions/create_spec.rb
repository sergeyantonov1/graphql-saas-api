# frozen_string_literal: true

require "rails_helper"

describe Subscriptions::Create do
  describe ".organized" do
    let(:expected_interactors) do
      [
        StripeResources::FindOrCreateCustomer,
        Subscriptions::CreateSubscription::PrepareUserParams,
        Users::SaveRecord,
        StripeResources::AttachCard,
        Subscriptions::CreateSubscription::PrepareParams,
        Subscriptions::SaveRecord,
        StripeResources::CreateSubscription
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
