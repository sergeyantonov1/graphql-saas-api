# frozen_string_literal: true

module Resolvers
  class UserItem < Resolvers::Base
    type Types::UserType, null: false

    def resolve(**options)
      User.first
    end
  end
end
