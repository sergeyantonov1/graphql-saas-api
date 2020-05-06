# frozen_string_literal: true

class SendInvitationEmailWorker
  include Sidekiq::Worker

  def perform()
    # do something
  end
end
