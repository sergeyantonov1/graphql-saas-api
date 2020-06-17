# frozen_string_literal: true

require "rails_helper"

describe StripeResources::FindOrCreateCustomer do
  include_context :interactor

  let(:initial_context) do
    {
      user: user
    }
  end

  let(:user) { create :user, email: "user@example.com", stripe_customer_id: stripe_customer_id }
  let(:stripe_customer_id) { "cus_123" }

  before do
    allow(Stripe::Subscription).to receive(:create)
  end

  describe "#call" do
    context "when stripe customer does not exist" do
      let(:stripe_customer_id) { nil }
      let(:created_stripe_customer) { double id: "cus_123_new" }

      before do
        allow(Stripe::Customer).to receive(:retrieve).with(stripe_customer_id).and_return(nil)
        allow(Stripe::Customer).to receive(:create).with(email: user.email).and_return(created_stripe_customer)
      end

      it_behaves_like :success_interactor

      it "creates stripe customer" do
        interactor.run

        expect(context.stripe_customer).to eq(created_stripe_customer)
      end
    end

    context "when stripe customer exists" do
      let(:stripe_customer) { double id: stripe_customer_id }

      before do
        allow(Stripe::Customer).to receive(:retrieve).with(stripe_customer_id).and_return(stripe_customer)
      end

      it_behaves_like :success_interactor

      it "retrieves stripe customer" do
        interactor.run

        expect(context.stripe_customer).to eq(stripe_customer)
      end
    end

    context "with stripe error" do
      let(:stripe_error) { Stripe::StripeError.new("Error message") }

      let(:error) { "Error message" }

      before do
        allow(Stripe::Customer).to receive(:retrieve)
        allow(Stripe::Customer).to receive(:create).and_raise(stripe_error)
      end

      it_behaves_like :failed_interactor
    end
  end
end
