ruby '2.6.5'

source 'https://rubygems.org'

gem 'breakpoint', '~> 2.7'
gem 'indieweb-endpoints', '~> 3.0'
gem 'rack', '~> 2.2'
gem 'rack-host-redirect', '~> 1.3'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'sass', '~> 3.7'
gem 'sass-globbing', '~> 1.1'
gem 'sinatra', '~> 2.0'
gem 'sinatra-asset-pipeline', '~> 2.2', require: 'sinatra/asset_pipeline'
gem 'sinatra-contrib', '~> 2.0'
gem 'sinatra-param', github: 'jgarber623/sinatra-param', tag: 'v3.2.0'

group :development, :test do
  gem 'rack-test', '~> 1.1'
  gem 'rake', '~> 12.3'
  gem 'reek', '~> 6.0', require: false
  gem 'rspec', '~> 3.9'
  gem 'rubocop', '~> 0.87.0', require: false
  gem 'rubocop-performance', '~> 1.6', require: false
  gem 'rubocop-rspec', '~> 1.40', require: false
  gem 'webmock', '~> 3.8', require: false
end

group :development do
  gem 'shotgun', '~> 0.9.2'
end

group :test do
  gem 'simplecov', '~> 0.18.5', require: false
  gem 'simplecov-console', '~> 0.7.2', require: false
end
