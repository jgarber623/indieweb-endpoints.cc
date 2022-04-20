# frozen_string_literal: true

RSpec.describe IndieWebEndpoints do
  subject(:app) { described_class.app }

  describe 'GET /' do
    let(:response) { get '/' }

    it { expect(response).to be_ok }
    it { expect(response.body).to include('Enter a URL to get started') }
  end
end
