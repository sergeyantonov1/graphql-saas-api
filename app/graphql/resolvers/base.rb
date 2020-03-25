# frozen_string_literal: true

module Resolvers
  class Base < GraphQL::Schema::Resolver
    argument_class Types::BaseArgument
  end
end
