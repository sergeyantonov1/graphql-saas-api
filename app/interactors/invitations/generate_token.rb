# frozen_string_literal: true

module Invitations
  class GenerateToken
    include Interactor

    delegate :email, to: :context

    def call
      context.token = generate_token
    end

    private

    def generate_token
      Digest::MD5.hexdigest([email, Time.current].join)
    end
  end
end
