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

  let(:company_params) do
    {
      name: "Company name"
    }
  end

  before do
    create :user, id: 123_123
  end

  describe ".call" do
    context "when new company" do
      let(:company) { build :company }

      let(:expected_attributes) do
        {
          name: "Company name"
        }
      end

      it "creates company" do
        expect { executed_context }.to change(Company, :count).by(1)

        expect(Company.last).to have_attributes(expected_attributes)
      end
    end

    context "when existed company" do
      let!(:company) { create :company }

      let(:expected_attributes) do
        {
          name: "Company name"
        }
      end

      it "updates company" do
        expect { executed_context }.not_to change(Company, :count)

        expect(Company.last).to have_attributes(expected_attributes)
      end
    end

    context "when invalid params" do
      let(:company) { build :company, name: nil }
      let(:company_params) { {} }

      let(:error_message) { "Name can't be blank" }

      it_behaves_like :failed_interactor
    end
  end
end
