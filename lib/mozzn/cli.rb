require 'thor'
require 'highline'
require 'cocaine'
require 'rubygems'
require 'git'
require 'mozzn/version'
require 'terminal-table'
require "mozzn/commands/key"
require "mozzn/commands/app"
require "mozzn/commands/auth"

module Mozzn
  class Cli < Thor
    include Thor::Actions
    
    default_task :help

    desc 'update', 'Check for updates'
    def update
      # TODO after gem release https://rubygems.org/api/v1/versions/mozzn.json
      @connection = Faraday.new('https://rubygems.org/api/v1/versions/coulda.json')
      response = @connection.get 
      body = JSON.parse(response.body)
      versions = body.map { |n| n['number'] }
      if Gem::Version.new(versions.last) > Gem::Version.new(Mozzn::VERSION)
        say 'An update is available. To install it run the following command "update gem mozzn"', :yellow
      else
        say 'You have the latest version.', :green
      end
    end

    desc 'help COMMAND', 'For more infromation about spicific COMMAND'
    def help command = nil
      puts 'Primary help topics, type "mozzn help COMMAND" for more details.'
      puts "Version: #{Mozzn::VERSION}"
      super command
    end

    desc "key subcommand", "Manage SSH keys"
    subcommand "key", Mozzn::Commands::Key

    desc "app subcommand", "Manage applications"
    subcommand "app", Mozzn::Commands::App

    desc "auth subcommand", "Manage your accountUser registration and login"
    subcommand "auth", Mozzn::Commands::Auth
  end  
end