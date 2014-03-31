require 'bundler/setup'
Bundler.setup

require 'rspec' 

RSpec.configure do |config|
	config.color_enabled = true
  config.include DisplayMessageMatcher
  config.order = 'rand'
end