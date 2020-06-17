# frozen_string_literal: true

require "rails_helper"

describe StripeResources::AttachCard do
  include_context :interactor

  let(:initial_context) do
    {
      stripe_customer: stripe_customer,
      stripe_token: stripe_token
    }
  end

  let(:stripe_customer) { double id: "cus_123" }
  let(:stripe_token) { "tok_visa" }

  before do
    allow(Stripe::Customer).to receive(:update)
  end

  describe "#call" do
    it_behaves_like :success_interactor

    it "attaches card" do
      expect(Stripe::Customer).to receive(:update).with(stripe_customer.id, source: stripe_token)

      interactor.run
    end

    context "with stripe error" do
      let(:stripe_error) { Stripe::StripeError.new("Error message") }

      let(:error) { "Error message" }

      before do
        allow(Stripe::Customer).to receive(:update).and_raise(stripe_error)
      end

      it_behaves_like :failed_interactor
    end
  end
end
