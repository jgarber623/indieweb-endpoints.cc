# frozen_string_literal: true

RSpec.describe IndieWebEndpointsApp do
  subject(:response) { last_response }

  describe "HEAD /" do
    before { head "/" }

    it { is_expected.to be_ok }
    its(:body) { is_expected.to be_empty }
  end

  describe "GET /" do
    before { get "/" }

    it { is_expected.to be_ok }
    its(:body) { is_expected.to include("Enter a URL to get started") }
  end

  describe "POST /" do
    let(:message) { "The requested method is not allowed" }

    context "when requesting text/html" do
      before do
        header "Accept", "text/html"
        post "/"
      end

      it { is_expected.to be_method_not_allowed }
      its(:body) { is_expected.to eq(message) }
    end

    context "when requesting application/json" do
      before do
        header "Accept", "application/json"
        post "/"
      end

      it { is_expected.to be_method_not_allowed }
      its(:body) { is_expected.to eq({ message: message }.to_json) }
    end
  end
end
