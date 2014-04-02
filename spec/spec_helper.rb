require 'bundler/setup'
require 'rspec' 

Bundler.setup

RSpec.configure do |config|
	config.color_enabled = true
  config.order = 'random'
  config.filter_run focused: true

  config.filter_run_excluding disabled: true

  config.run_all_when_everything_filtered = true
end