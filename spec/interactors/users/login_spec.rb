# frozen_string_literal: true

require "rails_helper"

describe Users::Login do
  describe ".organized" do
    let(:expected_interactors) do
      [
        Users::Authenticate,
        Users::GenerateToken
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
