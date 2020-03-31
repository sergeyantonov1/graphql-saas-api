# frozen_string_literal: true

module TransactionalInteractor
  extend ActiveSupport::Concern

  included do
    around do |interactor|
      if ActiveRecord::Base.connection.open_transactions == Rails.application.secrets.open_transactions_count
        ActiveRecord::Base.transaction do
          interactor.call(context)
        end
      else
        interactor.call(context)
      end
    end
  end
end
