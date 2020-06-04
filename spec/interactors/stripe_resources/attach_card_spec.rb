# frozen_string_literal: true

require "rails_helper"

describe StripeResources::AttachCard, :stub_stripe do
  include_context :interactor

  let(:initial_context) do
    {
      stripe_customer: stripe_customer,
      stripe_token: stripe_token
    }
  end

  let(:stripe_customer) { Stripe::Customer.create(email: "user@example.com") }
  let(:stripe_token) { stripe_helper.generate_card_token }

  before do
    StripeMock.prepare_error(:card_declined, :verify_source)
  end

  describe "#call" do
    it_behaves_like :success_interactor

    context "when invalid source" do
      let(:stripe_error) { Stripe::StripeError.new("Error message") }

      let(:error) { "Error message" }

      before do
        allow(Stripe::Customer).to receive(:update).and_raise(stripe_error)
      end

      it_behaves_like :failed_interactor
    end
  end
end
