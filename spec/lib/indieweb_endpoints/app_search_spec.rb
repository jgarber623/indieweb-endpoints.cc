describe IndiewebEndpoints::App do
  let(:message) { 'Parameter url is required and must be a valid URL (e.g. https://example.com)' }

  let(:example_url) { 'https://example.com' }

  let :http_response_headers do
    { 'Content-Type': 'text/html' }
  end

  let(:endpoints) do
    {
      authorization_endpoint: nil,
      micropub: nil,
      microsub: nil,
      redirect_uri: nil,
      token_endpoint: nil,
      webmention: 'https://example.com/webmention'
    }
  end

  context 'when GET /search' do
    context 'when url parameter is absent' do
      before do
        get '/search'
      end

      it 'renders the 400 view' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to include(message)
      end
    end

    context 'when url parameter protocol is invalid' do
      before do
        get '/search', url: 'ftp://example.com'
      end

      it 'renders the 400 view' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to include(message)
      end
    end

    context 'when url parameter is invalid' do
      before do
        get '/search', url: 'https://example.com<script>'
      end

      it 'renders the 400 view' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to include(message)
      end
    end

    context 'when url parameter is valid' do
      before do
        stub_request(:get, example_url).to_return(headers: http_response_headers, body: read_fixture(example_url))

        get '/search', url: example_url
      end

      it 'renders the search view' do
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include('https://example.com/webmention')
      end
    end
  end

  context 'when GET /search and Accept: application/json' do
    before do
      header 'Accept', 'application/json'
    end

    context 'when url parameter is absent' do
      before do
        get '/search'
      end

      it 'renders the 400 JSON' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq({ error: { code: 400, message: message } }.to_json)
      end
    end

    context 'when url parameter protocol is invalid' do
      before do
        get '/search', url: 'ftp://example.com'
      end

      it 'renders the 400 JSON' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq({ error: { code: 400, message: message } }.to_json)
      end
    end

    context 'when url parameter is invalid' do
      before do
        get '/search', url: 'https://example.com<script>'
      end

      it 'renders the 400 JSON' do
        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq({ error: { code: 400, message: message } }.to_json)
      end
    end

    context 'when url parameter is valid' do
      before do
        stub_request(:get, example_url).to_return(headers: http_response_headers, body: read_fixture(example_url))

        get '/search', url: example_url
      end

      it 'renders the search JSON' do
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq(endpoints.to_json)
      end
    end
  end
end
