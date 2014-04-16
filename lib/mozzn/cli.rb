require 'thor'
require 'highline'
require 'cocaine'
require 'rubygems'
require 'git'
require 'mozzn/version'
require 'terminal-table'

module Mozzn
  class Cli < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'login', 'Login with your mozzn credentials, an interactive shell will ask you about your email and password'
    # mozzn login
    method_option :email, :aliases => "-u", :desc => "Mozzn email"
    method_option :password, :aliases => "-p", :desc => "Mozzn password" 
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

    desc 'add_key', 'Add your SSH Public Key directily or add its path'
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
    # mozzn create_app
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

    def remove_app name = nil
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if !name.present?
        raise Thor::Error, "You must enter Application Name!"
      end
      params = {
        name: name
      }
      search_path = "applications/search"
      begin
      response = mozzn.get(search_path, params)
      if response.has_key?('info')
        raise Thor::Error, "#{response['info']}"
      else
        id = response['app_id']
        resources_path = "applications/#{id}/remove"
        response = mozzn.get(resources_path,nil)
        say response['info'], :green 
      end  
      rescue JSON::ParserError => e
        raise Thor::Error,"You do not have an application with the name #{params[:name]}. Please check the application name."
      end
      rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn. Check your internet connection!', :red
      rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput', :red
    end

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

    desc 'registration', 'Create an account on mozzn.'
    method_option :name, :aliases => "-n", :desc => "Username."
    method_option :email, :aliases => "-u", :desc => "User email used to login."
    method_option :password, :aliases => "-p", :desc => "User password."
    method_option :password_confirmation, :aliases => "-c", :desc => "Password_confirmation."
    
    def registration
      mozzn = Mozzn::Api.new
      if options.present?
        name = options[:name] 
        email = options[:email] 
        password = options[:password] 
        password_confirmation = options[:password_confirmation] 
      else
        h = HighLine.new
        name = h.ask("Username: ")
        email = h.ask("Email: ")
        password = h.ask("Password: ")
        password_confirmation = h.ask("password_confirmation: ")
      end
      params = {
        user: {
          name: name,
          email: email,
          password: password,
          password_confirmation: password_confirmation
        }
      }
      response = mozzn.post(:registrations, params)
      errors = response['data']['errors']
      if errors.present?
        errors = JSON.parse(errors)
        say "#{response['info']}, the following errors were found:\n * #{errors.map {|e| e.join(' ')}.join("\n * ")}\nPlease try again.", :red
        # TODO: re-run registration
      else
        say response['info'], :green
      end
    end

    desc 'resources appname', 'To list all instances which a specific application use.'
    
    def resources appname = nil
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
      if !appname.present?
        raise Thor::Error, "You must enter Application Name!"
      end
      params = {
        name: appname
      }
      search_path = "applications/search"
      begin
      response = mozzn.get(search_path, params)
      if response.has_key?('info')
        raise Thor::Error, "#{response['info']}"
      else
        id = response['app_id']
        resources_path = "applications/#{id}/resources"
        response = mozzn.get(resources_path,nil)
        if response.has_key?('info')
          raise Thor::Error, "#{response['info']}"
        else
          table1 = Terminal::Table.new(headings: ['Process', 'Command']) do |t|
            response['resources'].each do |resource|
              key = (resource.has_key?('command') ? resource['name'] : nil)
              value = (resource.has_key?('command') ? resource['command'] : nil)
              if key.present?
                t.add_row [key, value]
              end
            end
          end
          table2 = Terminal::Table.new(headings: ['Database', 'Role']) do |t|
            response['resources'].each do |resource|
              key = (resource.has_key?('role') ? resource['name'] : nil)
              value = (resource.has_key?('role') ? resource['role'] : nil)
              if key.present?
                t.add_row [key, value]
              end
            end
          end
        end
        instances_path = "applications/#{id}/instances"
        response = mozzn.get(instances_path,nil)
        # say response['instances'].first['data']['ip_address'].inspect, :green
        if response.has_key?('info')
          raise Thor::Error, "#{response['info']}"
        else
          table3 = Terminal::Table.new(headings: ['Name', 'IP']) do |t|
            response['instances'].each do |instant|
              key = instant['data']['name']
              value = instant['data']['ip_address']
              if key.present?
                t.add_row [key, value]
              end
            end
          end
        end
        say "Processes:"
        say "#{table1}"
        say "Databases:"
        say "#{table2}"
        say "Instances:"
        say "#{table3}"  
      end

      rescue JSON::ParserError => e
        raise Thor::Error,"You do not have an application with the name #{params[:appname]}. Please check the application name."
      end
    rescue Mozzn::Disconnected
      say 'Unable to connect to Mozzn. Check your internet connection!', :red
    rescue Mozzn::UnexpectedOutput
      say 'UnexpectedOutput', :red
    end

    desc 'console', 'To start a console on your first web server'
    def console 
      File.open(".git/config", "r") do |f|
        @data = f.read
      end 
      words = @data.match('.git')
      say words, :green
      # mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
    #   if !appname.present?
    #     raise Thor::Error, "You must enter Application Name!"
    #   end
    #   params = {
    #     name: appname
    #   }
    #   search_path = "applications/search"
    #   begin
    #     response = mozzn.get(search_path, params)
    #     if response.has_key?('info')
    #       raise Thor::Error, "#{response['info']}"
    #     else
    #       id = response['app_id']
    #       instances_path = "applications/#{id}/instances"
    #       response = mozzn.get(instances_path,nil)
    #       ip_address = response['instances'].first['data']['ip_address']
    #       system( "ssh app@#{ip_address}" )
    #       say $?.exitstatus, :green
    #     end
    #   rescue JSON::ParserError => e
    #     raise Thor::Error,"You do not have an application with the name #{params[:appname]}. Please check the application name."
    #   end
    # rescue Mozzn::Disconnected
    #   say 'Unable to connect to Mozzn. Check your internet connection!', :red
    # rescue Mozzn::UnexpectedOutput
    #   say 'UnexpectedOutput', :red
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