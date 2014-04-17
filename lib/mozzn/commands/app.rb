module Mozzn
  module Commands
    class App < Thor

      desc 'create APPNAME', 'create a new application'

      def create name = nil
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
        if response.has_key?('message')
          raise Thor::Error, "#{response['message']}"
        else
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
            say 'Git remote already configured, skipping...'
          end
        end
      rescue Mozzn::Disconnected
        say 'Unable to connect to Mozzn check the internet connection!', :red
      rescue Mozzn::UnexpectedOutput
        say 'UnexpectedOutput', :red
      end

      desc 'remove APPNAME', 'Remove spcicfic Application'
      def remove name = nil
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
      desc "list", "List all your Applications."

      def list
      #TODO  
      end

      desc 'resources APPNAME', 'To list all instances which a specific application use'
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
    method_option :name, :aliases => "-c", :desc => "Command to be run in console."
    def console 
      mozzn = Mozzn::Api.new(Mozzn::Config.new.read['token'])
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
          instances_path = "applications/#{id}/instances"
          response = mozzn.get(instances_path,nil)
          ip_address = response['instances'].first['data']['ip_address']
          if options[:command].present?
            system( "ssh app@#{ip_address} #{options[:command]}" )
          else
            system( "ssh app@#{ip_address}")
          end
          status = $?.exitstatus
        end
      rescue JSON::ParserError => e
        raise Thor::Error,"You do not have an application with the name #{params[:name]}. Please check the application name."
      end
      rescue Mozzn::Disconnected
        say 'Unable to connect to Mozzn. Check your internet connection!', :red
      rescue Mozzn::UnexpectedOutput
        say 'UnexpectedOutput', :red
      end 
    no_commands do
      # desc 'git_check', 'checks if user has git installed in $PATH or not'
      def appname
        config_file_path = ".git/config"
        if File.exists?(config_file_path)
          File.open(config_file_path, "r") do |f|
            @data = f.read
          end
        else
          raise Thor::Error,"Unable to find a repository for this directory. You probably not in the application directory or this application does not have git repository yet."
        end
        url = @data.scan /url =.*/
        app = url.first.split(":")[1] 
        appname = app.split('.').first
      end
    end
  end
end


end