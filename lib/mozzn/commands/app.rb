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

  desc 'remove APPNAME', 'Remove spcicfic Application.'

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
    
  end
end