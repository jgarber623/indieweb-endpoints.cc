RSpec.describe IndiewebEndpoints::App do
  let(:message) { 'The request timed out and could not be completed' }

  let(:example_url) { 'https://example.com' }

  context 'when GET /search' do
    before do
      stub_request(:get, example_url).to_timeout

      get '/search', url: example_url
    end

    it 'renders the 408 message' do
      expect(last_response.status).to eq(408)
      expect(last_response.body).to include(message)
    end
  end
end
