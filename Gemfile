ruby '2.7.2'

source 'https://rubygems.org'

gem 'breakpoint', '~> 2.7'
gem 'indieweb-endpoints', '~> 5.0'
gem 'rack', '~> 2.2'
gem 'rack-host-redirect', '~> 1.3'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'sass', '~> 3.7'
gem 'sass-globbing', '~> 1.1'
gem 'sinatra', '~> 2.0'
gem 'sinatra-asset-pipeline', '~> 2.2', require: 'sinatra/asset_pipeline'
gem 'sinatra-contrib', '~> 2.0'
gem 'sinatra-param', github: 'jgarber623/sinatra-param', tag: 'v3.4.0'

group :development, :test do
  gem 'bundler-audit'
  gem 'rack-test'
  gem 'rake'
  gem 'reek', require: false
  gem 'rspec'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'webmock', require: false
end

group :development do
  gem 'shotgun'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
