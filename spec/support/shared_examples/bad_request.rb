# frozen_string_literal: true

RSpec.shared_examples "a bad request" do
  let(:message) { "Parameter url is required and must be a valid URL (e.g. https://example.com)" }

  context "when requesting text/html" do
    before do
      header "Accept", "text/html"
      request
    end

    it { is_expected.to be_bad_request }
    its(:body) { is_expected.to include(message) }
  end

  context "when requesting application/json" do
    before do
      header "Accept", "application/json"
      request
    end

    it { is_expected.to be_bad_request }
    its(:body) { is_expected.to eq({ message: message }.to_json) }
  end
end
