# frozen_string_literal: true

RSpec.describe App do
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
    context "when no url param" do
      let(:request) { post "/" }

      include_examples "a bad request"
    end

    context "when invalid url param protocol" do
      let(:request) { post "/", url: "ftp://example.com" }

      include_examples "a bad request"
    end

    context "when invalid url param" do
      let(:request) { post "/", url: "https://example.com<script>" }

      include_examples "a bad request"
    end

    context "when valid url param" do
      before do
        header "Accept", "text/html"
        post "/", url: "https://example.com"
      end

      it { is_expected.to be_redirect }
    end
  end
end
