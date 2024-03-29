# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.3"

gem "pg"
gem "rails", "6.0.2.1"

gem "action_policy-graphql"
gem "bcrypt"
gem "bootsnap", require: false
gem "decent_exposure"
gem "devise"
gem "devise-jwt"
gem "enumerize"
gem "graphql"
gem "interactor"
gem "puma"
gem "rubocop"
gem "sidekiq"
gem "stripe"
gem "stripe_event"

group :development do
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
end

group :development, :test do
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "rspec-rails"
end

group :test do
  gem "database_cleaner-active_record"
  gem "simplecov", require: false
  gem "stripe-ruby-mock", require: "stripe_mock"
  gem "timecop"
  gem "webmock"
end
