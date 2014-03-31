require 'bundler/setup'
require 'rspec' 

Bundler.setup

RSpec.configure do |config|
	config.color_enabled = true
  config.order = 'random'
end