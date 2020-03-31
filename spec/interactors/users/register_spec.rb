# frozen_string_literal: true

require "rails_helper"

describe Users::Register do
  describe ".organized" do
    let(:expected_interactors) do
      [
        Users::SaveRecord,
        Users::GenerateToken,
        Users::SaveToken
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
