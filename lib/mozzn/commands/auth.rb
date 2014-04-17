module Mozzn
  module Commands
    class Auth < Thor
      desc 'register', 'Create an account on mozzn'
      
      method_option :name, :aliases => "-n", :desc => "Username."
      method_option :email, :aliases => "-u", :desc => "User email used to login."
      method_option :password, :aliases => "-p", :desc => "User password."
      method_option :password_confirmation, :aliases => "-c", :desc => "Password_confirmation."    
      def register
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
end