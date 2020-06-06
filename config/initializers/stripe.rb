Stripe.api_key = ENV.fetch("STRIPE_API_KEY")
StripeEvent.signing_secret = ENV["STRIPE_SIGNING_SECRET"]

StripeEvent.configure do |events|
  events.subscribe "customer.subscription.created" do |event|
    StripeHandlers::HandleSubscriptionCreatedEvent.call(event: event)
  end

  events.subscribe "customer.subscription.deleted" do |event|
    StripeHandlers::HandleSubscriptionDeletedEvent.call(event: event)
  end
end
