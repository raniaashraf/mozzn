require "mozzn/extensions"
require "mozzn/version"
require 'mozzn/config'
require 'mozzn/api'
require 'mozzn/cli'


module Mozzn
  class << self
    def start 
      # Invoke our CLI
      Mozzn::Cli.start
    end
  end
end
