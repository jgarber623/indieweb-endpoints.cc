# frozen_string_literal: true

RSpec.describe IndieWebEndpointsApp, roda: :app do
  describe 'GET /foo' do
    let(:message) { 'The requested URL could not be found' }

    context 'when requesting text/html' do
      before do
        header 'Accept', 'text/html'
        get '/foo'
      end

      it { is_expected.to be_not_found }
      its(:body) { is_expected.to include(message) }
    end

    context 'when requesting application/json' do
      before do
        header 'Accept', 'application/json'
        get '/foo'
      end

      it { is_expected.to be_not_found }
      its(:body) { is_expected.to eq({ message: message }.to_json) }
    end
  end
end
