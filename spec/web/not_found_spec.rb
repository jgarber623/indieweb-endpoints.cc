# frozen_string_literal: true

RSpec.describe IndieWebEndpoints do
  subject(:app) { described_class.app }

  describe 'GET /foo' do
    let(:message) { 'The requested URL could not be found' }

    context 'when requesting text/html' do
      let(:response) { get '/foo' }

      it { expect(response).to be_not_found }
      it { expect(response.body).to include(message) }
    end

    context 'when requesting application/json' do
      let(:response) do
        header 'Accept', 'application/json'
        get '/foo'
      end

      it { expect(response).to be_not_found }
      it { expect(response.body).to eq({ error: { code: 404, message: message } }.to_json) }
    end
  end
end
