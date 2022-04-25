# frozen_string_literal: true

RSpec.describe IndieWebEndpoints, roda: :app do
  describe 'GET /' do
    before { get '/' }

    it { is_expected.to be_ok }
    its(:body) { is_expected.to include('Enter a URL to get started') }
  end
end
