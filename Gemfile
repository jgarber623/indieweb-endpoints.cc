# frozen_string_literal: true

ruby file: ".ruby-version"

source "https://rubygems.org"

gem "indieweb-endpoints"
gem "puma"
gem "rack"
gem "rack-host-redirect"
gem "rake"
gem "roda"
gem "roda-sprockets"
gem "sprockets-sass_embedded"
gem "tilt"

group :development do
  gem "debug"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false
end

group :test do
  gem "bundler-audit", require: false
  gem "rack-test"
  gem "rspec"
  gem "rspec-its"
  gem "simplecov", require: false
  gem "simplecov-console", require: false
  gem "webmock", require: false
end
