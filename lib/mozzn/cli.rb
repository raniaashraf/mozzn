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
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'update', 'To show if there is an update for the CLI'
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

    desc "Key subcommand", "List, add and remove keys."
    subcommand "key", Mozzn::Commands::Key

    desc "App subcommand", "List, add and remove applications."
    subcommand "app", Mozzn::Commands::App

    desc "Auth subcommand", "User registration and login."
    subcommand "auth", Mozzn::Commands::Auth
  end  
end