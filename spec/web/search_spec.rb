# frozen_string_literal: true

RSpec.describe IndieWebEndpointsApp do
  subject(:response) { last_response }

  describe "GET /search" do
    let(:example_url) { "https://example.com" }

    context "when no url param" do
      let(:request) { get "/search" }

      include_examples "a bad request"
    end

    context "when invalid url param protocol" do
      let(:request) { get "/search", url: "ftp://example.com" }

      include_examples "a bad request"
    end

    context "when invalid url param" do
      let(:request) { get "/search", url: "https://example.com<script>" }

      include_examples "a bad request"
    end

    context "when request timeout" do
      let(:message) { "The request timed out and could not be completed" }

      before do
        stub_request(:get, example_url).to_timeout
      end

      context "when requesting text/html" do
        before do
          header "Accept", "text/html"
          get "/search", url: example_url
        end

        it { is_expected.to be_request_timeout }
        its(:body) { is_expected.to include(message) }
      end

      context "when requesting application/json" do
        before do
          header "Accept", "application/json"
          get "/search", url: example_url
        end

        it { is_expected.to be_request_timeout }
        its(:body) { is_expected.to eq({ message: message }.to_json) }
      end
    end

    context "when valid url param" do
      before do
        stub_request(:get, example_url).to_return(
          headers: { "Content-Type": "text/html" },
          body: '<html><head><link rel="webmention" href="/webmention"></head></html>'
        )
      end

      context "when requesting text/html" do
        before do
          header "Accept", "text/html"
          get "/search", url: example_url
        end

        it { is_expected.to be_ok }
        its(:body) { is_expected.to include("https://example.com/webmention") }
      end

      context "when requesting application/json" do
        let(:endpoints) do
          {
            authorization_endpoint: nil,
            "indieauth-metadata": nil,
            micropub: nil,
            microsub: nil,
            redirect_uri: nil,
            token_endpoint: nil,
            webmention: "https://example.com/webmention"
          }
        end

        before do
          header "Accept", "application/json"
          get "/search", url: example_url
        end

        it { is_expected.to be_ok }
        its(:body) { is_expected.to eq(endpoints.to_json) }
      end
    end
  end
end
