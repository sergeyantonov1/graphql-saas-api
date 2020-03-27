# frozen_string_literal: true

shared_examples :success_interactor do
  it "succeeds" do
    interactor.run

    expect(context).to be_success
  end
end
