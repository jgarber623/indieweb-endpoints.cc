# frozen_string_literal: true

ruby '3.1.2'

source 'https://rubygems.org'

gem 'puma'
gem 'rack'
gem 'rack-host-redirect'
gem 'rake'
gem 'roda', github: 'jeremyevans/roda', ref: 'ef859de'
gem 'roda-sprockets'
gem 'sassc'
gem 'tilt'

group :development do
  gem 'pry-byebug'
  gem 'rerun'
end

group :test do
  gem 'bundler-audit', require: false
  gem 'code-scanning-rubocop', require: false
  gem 'rack-test'
  gem 'rspec'
  gem 'rspec-its'
  gem 'rspec-github', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
