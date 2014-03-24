require 'thor'
require 'terminal-table'
require 'highline'

module Mozzn
  class CLI < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    default_task :help

    desc 'login', 'User signin mozzn using email and password'
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
      auth_token = response['data']['auth_token'].inspect
      Mozzn.config.add('token', auth_token)
    end


    
  end  
end