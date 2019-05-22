describe IndiewebEndpoints::App do
  let(:message) { 'The requested method is not allowed' }

  context 'when POST /' do
    before do
      post '/'
    end

    it 'renders the 405 message' do
      expect(last_response.status).to eq(405)
      expect(last_response.body).to eq(message)
    end
  end
end
