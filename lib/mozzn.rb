require "mozzn/version"
require 'mozzn/config'
require 'mozzn/chimera'
require 'mozzn/cli'


module Mozzn
  class << self
    attr_accessor  :config
    def start
      # Now load the congiuration
      @config = Mozzn::Config.new

      @chimera = Mozzn::Chimera.new

      # Invoke our CLI
      Mozzn::CLI.start
    end
  end
end
