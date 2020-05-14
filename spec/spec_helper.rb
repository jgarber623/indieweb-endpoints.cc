require 'simplecov'
require 'webmock/rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path('../config/environment', __dir__)

Dir.glob(File.join(Dir.pwd, 'spec', 'support', '**', '*.rb')).sort.each { |f| require f }

RSpec.configure do |config|
  config.include FixtureHelpers
  config.include RSpecMixin

  config.disable_monkey_patching!
end
