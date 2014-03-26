require "mozzn/version"
require 'mozzn/config'
require 'mozzn/api'
require 'mozzn/cli'
require 'mozzn/logger'


module Mozzn
  class << self
    attr_accessor   :debug, :log,:config
    def start debug
      @debug = debug
      # Initialize log first
      @log = Mozzn::Logger.new
      # Now load the congiuration
      @config = Mozzn::Config.new

      @chimera = Mozzn::Api.new

      # Invoke our CLI
      Mozzn::CLI.start
    end
  end
end
