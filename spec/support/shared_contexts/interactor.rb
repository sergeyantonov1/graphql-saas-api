# frozen_string_literal: true

shared_context :interactor do
  let(:interactor) { described_class.new(initial_context) }
  let(:executed_context) { described_class.call(initial_context) }
  let(:initial_context) { {} }
  let(:context) { interactor.context }
  let(:expected_context) do
    Interactor::Context.new(initial_context.merge(expected_context_params))
  end
end
