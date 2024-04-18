# frozen_string_literal: true

RSpec.describe App do
  subject(:response) { last_response }

  describe "GET /foo" do
    let(:request) { get "/foo" }

    include_examples "a not found request"
  end
end
