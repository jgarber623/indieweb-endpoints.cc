# frozen_string_literal: true

RSpec.shared_examples "a not found request" do
  let(:message) { "The requested URL could not be found" }

  context "when requesting text/html" do
    before do
      header "Accept", "text/html"
      request
    end

    it { is_expected.to be_not_found }
    its(:body) { is_expected.to include(message) }
  end

  context "when requesting application/json" do
    before do
      header "Accept", "application/json"
      request
    end

    it { is_expected.to be_not_found }
    its(:body) { is_expected.to eq({ message: message }.to_json) }
  end
end
