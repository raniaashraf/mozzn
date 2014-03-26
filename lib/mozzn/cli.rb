require 'thor'
require 'terminal-table'
require 'highline'
require 'cocaine'
require 'rubygems'
require 'git'

module Mozzn
  class CLI < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'login', 'Login with your mozzn credentials'
    # mozzn login 
    def login 
      mozzn = Mozzn::Api.new
      hl = HighLine.new
      email = hl.ask 'Mozzn email: '
      password = hl.ask('Mozzn password (we will not store this): ') { |q| q.echo = "*" }
      params = {
        user: {
          email: email,
          password: password
        }
      }
      response = mozzn.post(:sessions, params)
      auth_token = response['data']['auth_token']
      if auth_token == nil
        say response['info'], :red
      else
        Mozzn.config.add('token', auth_token) 
        say response['info'], :green 
        git_check
        ssh_key_check
      end
    end

    desc 'add_key PUBLIC_KEY', 'add your ssh public key'
    # mozzn add_key
    def add_key public_key = nil
      mozzn = Mozzn::Api.new
      if public_key == nil
        hl = HighLine.new
        public_key = hl.ask 'Public Key: '
      end
      auth_token = Mozzn.config.read['token']
      path = "keys\?auth_token\=#{auth_token}"
      params = {
        key: {
          public: public_key
        }
      }
      response = mozzn.post(path, params)
      say response['info'], :green
    end

    desc 'create_app APPNAME', 'create a new application'
    # mozzn create_app
    def create_app name = nil
      mozzn = Mozzn::Api.new
      if name == nil
        hl = HighLine.new
        name = hl.ask 'Application name: '
      end
      auth_token = Mozzn.config.read['token']
      path = "applications\?auth_token\=#{auth_token}"
      params = {
        application: {
          name: name
        }
      }
      response = mozzn.post(path, params)
      say response['info'], :green
      git = Git.init
      unless File.exist?('.git')
          git.add(:all=>true)
        begin
          git.commit('First commit')
        rescue Git::GitExecuteError => e
          output = 'Nothing added to be commit.' 
          say output, :red
          return false
        end
      end
      begin
        git.add_remote("mozzn", "git@git.mozzn.com:#{name}.git")
      rescue Git::GitExecuteError => e
        output = 'You already have this remote.' 
        say output, :red
        return false
      end
    end

    desc 'help COMMAND', 'For more infromation about spicific COMMAND'
    def help command = nil
      puts 'Primary help topics, type "mozzn help COMMAND" for more details:'
      puts 'Version: 0.0.1'
      super command
    end

    no_commands do
      desc 'git_check', 'checks if user has git installed in $PATH or not'
      def git_check
        line = Cocaine::CommandLine.new("which git")
        begin
          output = line.run
        rescue Cocaine::ExitStatusError => e
          output = 'Unable to find git it is either not installed or not in your $PATH.' 
          say output, :red
          return false
        end
      end

      desc 'ssh_key_check', 'checks if user has ssh key in ~/.ssh path'
      def ssh_key_check
        ssh = ['~/.ssh/id_rsa.pub','~/.ssh/id_dsa.pub']
        unless ssh.map { |ssh| File.exist?(File.expand_path(ssh))} 
          say "Unable to find an SSH key in #{File.expand_path('~/.ssh/')}. ", :red
        end
      end      
    end
  end  
end