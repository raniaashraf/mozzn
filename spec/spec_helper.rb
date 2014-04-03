require 'bundler/setup'
require 'rspec' 

Bundler.setup

# Copied from: https://github.com/erikhuda/thor/blob/master/spec/helper.rb#L49

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

RSpec.configure do |config|
	config.color_enabled = true
  config.order = 'random'
  config.filter_run focused: true

  config.filter_run_excluding disabled: true

  config.run_all_when_everything_filtered = true
end