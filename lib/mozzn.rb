require "mozzn/extensions"
require "mozzn/version"
require 'mozzn/config'
require 'mozzn/api'
require 'mozzn/cli'


module Mozzn
  class << self
    attr_accessor :config
    def start 
      # Now load the congiuration
      @config = Mozzn::Config.new

      @chimera = Mozzn::Api.new
      # Invoke our CLI
      Mozzn::CLI.start
    end
  end
end
