describe IndiewebEndpoints::App do
  context 'when GET /' do
    before do
      get '/'
    end

    it 'renders the index view' do
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include('Submit')
    end
  end
end
