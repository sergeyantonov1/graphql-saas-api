# frozen_string_literal: true

module Companies
  class SaveRecord
    include Interactor

    delegate :company, :company_params, to: :context

    def call
      context.fail!(error: error_message) unless save_company
    end

    private

    def save_company
      company.update(company_params)
    end

    def error_message
      company.errors.full_messages.join(", ")
    end
  end
end
