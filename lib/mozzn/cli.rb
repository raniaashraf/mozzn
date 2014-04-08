require 'thor'
require 'highline'
require 'cocaine'
require 'rubygems'
require 'git'
require 'mozzn/version'

module Mozzn
  # This class represents the Command Line Interface of mozzn Apis.
  class Cli < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'login', 'Login with your mozzn credentials'
    
    method_option :email, :aliases => "-u", :desc => "Mozzn email"
    method_option :password, :aliases => "-p", :desc => "Mozzn password"
    
    # Login to mozzn using your mozzn email and password.
    #
    # Usage:
    # mozzn login -u "foo@example.com" -p "12345678" 
    # or 
    # mozzn login 
    # An interactive shell will ask for your Mozzn email and password
    # 
    # An Error is raised if you do not provide both email and password
    # or if you provide wrong email or password. 

    def login
      mozzn = Mozzn::Api.new
      if options[:email].nil? && options[:password].nil?
        hl = HighLine.new
        email = hl.ask 'Mozzn email: '
        password = hl.ask('Mozzn password (we will not store this): ') { |q| q.echo = "*" }
      elsif options[:email].nil? || options[:password].nil?
        raise Thor::Error, "Email and password must be provided!"
      else
        email = options[:email]
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
        raise Thor::Error, response['info']
      else
        Mozzn::Config.new.add('token', auth_token) 
        say response['info'], :green 
        git_check
        ssh_key_check
      end
    rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn. Please check your internet connection.', :red
    rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput', :red
    end

    desc 'add_key', 'Add your SSH Public Key'
    
    method_option :public_key, :aliases => "-k", :desc => "RSA/DSA public key"
    method_option :key_path, :aliases => "-p", :desc => "Path to RSA/DSA public key"
    
    # Add an SSH public key.
    #
    # Usage:
    # mozzn add_key -k "RSA/DSA public key" 
    # or 
    # mozzn add_key -p "Path to RSA/DSA public key on your computer" 
    # 
    # An Error is raised if you do not provide a valid public SSH key
    # or if you provide wrong path of your RSA/DSA public key.
    
    def add_key
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if options[:key_path].present?
        key_path = File.expand_path(options[:key_path])
      elsif options[:public_key].present?
        public_key = options[:public_key]
      else
        raise Thor::Error, "Neither a key path or an SSH key were provided. You must use -p or -k options."
      end

      if public_key.nil?
        if File.exist?(key_path)
          File.open(key_path, "rb") do |f|
            public_key = f.read
          end
        else
          raise Thor::Error, "Unable to read #{key_path}. File does not exist or not accessible."
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
    rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn check the internet connection!', :red
    rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput', :red
    end

    desc 'create_app APPNAME', 'create a new application'

    # Create a new application on mozzn.
    #
    # Usage:
    # mozzn create "application_name" 
    # 
    # It will create an application on mozzn 
    #
    # If you in the application path, an initial repository will be created
    # if the application does not has one, a remote will be added with name "mozzn", 
    # and your application will be commited 
    #
    # An Error is raised if you create an application with name you provide for another application
    # or if you provide application name with spaces.

    def create_app name = nil
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if name == nil
        raise Thor::Error, "You must enter application name."
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
          git.add(all: true)
        begin
          git.commit('First commit')
        rescue Git::GitExecuteError => e
          # Do nothing
        end
      end
      begin
        git.add_remote("mozzn", "git@git.mozzn.com:#{name}.git")
      rescue Git::GitExecuteError => e
        say 'You already have this remote.', :red
      end
    rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn check the internet connection!', :red
    rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput'
    end

    desc 'remove_app APPNAME', 'Remove spcicfic Application.'

    # Remove spcicfic Application..
    #
    # Usage:
    # mozzn remove_app "application_name" 
    # 
    # It will remove a specific application from your applications on mozzn 
    #
    # An Error is raised if you try to remove an applicaion which is does not exist.

    def remove_app name = nil
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if !name.present?
        raise Thor::Error, "You must enter Application Name!"
      end
      params = {
        name: name
      }
      path = 'applications'
      begin
      response = mozzn.get(path, params)
        say response['info'], :green   
      rescue JSON::ParserError => e
        raise Thor::Error,"You do not have an application with the name #{params[:name]}. Please check the application name."
      end
    rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn. Check your internet connection!', :red
    rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput', :red
    end

    desc 'update', 'To show if there is an update for the CLI'

    # To show if there is an update for the CLI.
    #
    # Usage:
    # mozzn update 

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

    no_commands do
      desc 'git_check', 'checks if user has git installed in $PATH or not'
      def git_check
        line = Cocaine::CommandLine.new("which git")
        begin
          output = line.run
        rescue Cocaine::ExitStatusError => e
          raise Thor::Error, 'Unable to find git it is either not installed or not in your $PATH. You may need to install it or add it to $PATH.' 
        end
      end

      desc 'ssh_key_check', 'checks if user has ssh key in ~/.ssh path'
      def ssh_key_check
        ssh = ['~/.ssh/id_rsa.pub','~/.ssh/id_dsa.pub']
        unless ssh.map { |ssh| File.exist?(File.expand_path(ssh))} 
          raise Thor::Error, "Unable to find an SSH key in #{File.expand_path('~/.ssh/')}. "
        end
      end
    end
  end  
end