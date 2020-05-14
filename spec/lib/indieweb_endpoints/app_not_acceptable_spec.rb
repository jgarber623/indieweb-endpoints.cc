RSpec.describe IndiewebEndpoints::App do
  let(:message) { 'The requested format is not supported' }

  before do
    header 'Accept', 'text/plain'
  end

  context 'when GET /' do
    before do
      get '/'
    end

    it 'renders the 406 message' do
      expect(last_response.status).to eq(406)
      expect(last_response.body).to eq(message)
    end
  end

  context 'when GET /search' do
    before do
      get '/search', url: 'https://example.com'
    end

    it 'renders the 406 message' do
      expect(last_response.status).to eq(406)
      expect(last_response.body).to eq(message)
    end
  end
end
