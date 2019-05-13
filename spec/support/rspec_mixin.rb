module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end
