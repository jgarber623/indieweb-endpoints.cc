# frozen_string_literal: true

require_relative "config/environment"

RubyVM::YJIT.enable

run IndieWebEndpointsApp.freeze.app
