# frozen_string_literal: true

require 'debug'
require 'simplecov'
require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'

require_relative '../config/environment'

Dir.glob(File.join(__dir__, 'support/**/*.rb')).each { |f| require_relative f }

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.disable_monkey_patching!

  def app
    IndieWebEndpoints.freeze.app
  end
end
