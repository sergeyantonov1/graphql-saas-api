# frozen_string_literal: true

require "rails_helper"

describe Companies::SaveRecord do
  include_context :interactor

  let(:initial_context) do
    {
      company: company,
      company_params: company_params
    }
  end

  let(:company) { nil }
  let(:company_params) do
    {
      name: "Company name"
    }
  end

  let(:expected_attributes) do
    {
      name: "Company name"
    }
  end

  before do
    create :user, id: 123_123
  end

  describe ".call" do
    it "creates company" do
      expect { interactor.run }.to change(Company, :count).by(1)

      expect(context.company).to have_attributes(expected_attributes)
    end

    context "when company exists" do
      let!(:company) { create :company }

      it "updates company" do
        expect { interactor.run }.not_to change(Company, :count)

        expect(context.company).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:company_params) { { name: nil } }

      let(:error_message) { "Name can't be blank" }

      it_behaves_like :failed_interactor
    end
  end
end
