# frozen_string_literal: true

shared_examples :failed_interactor do
  it "failures" do
    interactor.run

    expect(context).to be_failure
    expect(context.error).to eq(error_message) if respond_to?(:error_message)
    expect(context.error_data).to eq(error_data) if respond_to?(:error_data)
  end
end
