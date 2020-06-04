# frozen_string_literal: true

module StripeHelper
  def stripe_helper
    StripeMock.create_test_helper
  end
end

RSpec.configure do |config|
  config.include StripeHelper

  config.before :each, :stub_stripe do
    StripeMock.start
  end

  config.after :each, :stub_stripe do
    StripeMock.stop
  end
end
