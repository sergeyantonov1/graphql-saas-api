# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  mount StripeEvent::Engine, at: "stripe/webhook"

  post "/graphql", to: "graphql#execute"
end
