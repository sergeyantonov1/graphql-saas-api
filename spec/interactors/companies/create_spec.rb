# frozen_string_literal: true

require "rails_helper"

describe Companies::Create do
  describe ".organized" do
    let(:expected_interactors) do
      [
        Companies::SaveRecord,
        Memberships::PrepareOwnerParams,
        Memberships::SaveRecord
      ]
    end

    subject { described_class.organized }

    it { is_expected.to eq(expected_interactors) }
  end
end
