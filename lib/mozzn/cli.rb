require 'thor'
require 'terminal-table'
require 'highline'
require 'cocaine'
require 'rubygems'
require 'git'
require 'mozzn/version'

module Mozzn
  class Cli < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'login', 'Login with your mozzn credentials'
    # mozzn login
    method_option :email, :aliases => "-e", :desc => "Mozzn email"
    method_option :password, :aliases => "-p", :desc => "Mozzn password" 
    def login
      mozzn = Mozzn::Api.new
      if !(options[:email].present? && options[:password].present?)
        hl = HighLine.new
        email = hl.ask 'Mozzn email: '
        password = hl.ask('Mozzn password (we will not store this): ') { |q| q.echo = "*" }
      else
        emial = options[:email]
        password = options[:password]
      end
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
        Mozzn::Config.new.add('token', auth_token) 
        say response['info'], :green 
        git_check
        ssh_key_check
      end
    end

    desc 'add_key', 'Add your SSH Public Key'
    method_option :public_key, :aliases => "-k", :desc => "RSA/DSA public key"
    method_option :key_path, :aliases => "-p", :desc => "Path to RSA/DSA public key"
    # mozzn add_key
    def add_key
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if options[:key_path].present?
        key_path = File.expand_path(options[:key_path])
      elsif options[:public_key].present?
        public_key = options[:public_key]
      else
        say "You must enter an SSH key path or a public SSH key! " , :red
        return
      end

      if public_key.nil?
        if File.exist?(key_path)
          File.open(key_path, "rb") do |f|
            public_key = f.read
          end
        else
          say "Unable to read #{key_path}, file does not exist or not accessible!", :red
          return
        end
      end

      path = 'keys'
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
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if name == nil
        say 'You must enter Application Name! ', :red
        return
      end
      path = 'applications'
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

    desc 'remove_app APPNAME', 'Remove spcicfic Application.'

    def remove_app name = nil
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if !name.present?
        say "You must enter Application Name!", :red
        return
      end
      params = {
        name: name
      }
      path = 'applications'
      begin
      response = mozzn.get(path, params)
        say response['info'], :green   
      rescue JSON::ParserError => e
        say "You do not have an application with name #{params[:name]}!", :red
        return false 
      end
      
    end

    desc 'help COMMAND', 'For more infromation about spicific COMMAND'
    def help command = nil
      puts 'Primary help topics, type "mozzn help COMMAND" for more details:'
      puts "Version: #{Mozzn::VERSION}"
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