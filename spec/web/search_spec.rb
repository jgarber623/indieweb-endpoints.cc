# frozen_string_literal: true

RSpec.describe App do
  subject(:response) { last_response }

  let(:example_url) { "https://example.com" }

  describe "GET /u" do
    context "when no url param" do
      let(:request) { get "/u" }

      include_examples "a not found request"
    end

    context "when unsupported url param protocol" do
      let(:request) { get "/u/ftp://example.com" }

      include_examples "a not found request"
    end

    context "when localhost url param" do
      let(:request) { get "/u/http://localhost" }

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
          get "/u/#{example_url}"
        end

        it { is_expected.to be_request_timeout }
        its(:body) { is_expected.to include(message) }
      end

      context "when requesting application/json" do
        before do
          header "Accept", "application/json"
          get "/u/#{example_url}"
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
          get "/u/#{example_url}"
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
          get "/u/#{example_url}"
        end

        it { is_expected.to be_ok }
        its(:body) { is_expected.to eq(endpoints.to_json) }
      end
    end
  end

  describe "POST /u" do
    let(:message) { "The requested method is not allowed" }

    context "when requesting text/html" do
      before do
        header "Accept", "text/html"
        post "/u/#{example_url}"
      end

      it { is_expected.to be_method_not_allowed }
      its(:body) { is_expected.to eq(message) }
    end

    context "when requesting application/json" do
      before do
        header "Accept", "application/json"
        post "/u/#{example_url}"
      end

      it { is_expected.to be_method_not_allowed }
      its(:body) { is_expected.to eq({ message: message }.to_json) }
    end
  end
end
