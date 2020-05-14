RSpec.describe IndiewebEndpoints::App do
  let(:message) { 'The requested URL could not be found' }

  context 'when GET /foo' do
    before do
      header 'Accept', 'text/html'

      get '/foo'
    end

    it 'renders the 404 view' do
      expect(last_response.status).to eq(404)
      expect(last_response.body).to include(message)
    end
  end

  context 'when GET /foo and Accept: application/json' do
    before do
      header 'Accept', 'application/json'

      get '/foo'
    end

    it 'renders the 404 JSON' do
      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq({ error: { code: 404, message: message } }.to_json)
    end
  end
end
