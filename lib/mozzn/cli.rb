require 'thor'
require 'terminal-table'
require 'highline'

module Mozzn
  class CLI < Thor
    include Thor::Actions
    
    trap(:INT) { exit 1 }
    
    # default_task :help

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

    desc 'add_key', 'User adds his ssh public key'
    # mozzn login
    def add_key
      mozzn = Mozzn::Api.new
      hl = HighLine.new
      auth_token = Mozzn.config.read['token'].to_s
      puts auth_token
      path = "keys\?auth_token\="+ auth_token.to_s
      puts path
      # public_key = hl.ask 'Public Key: '
      # params = {
      #   key: {
      #     public: public_key
      #   }
      # }
      # response = mozzn.post(path, params)
      # puts response.inspect
      
    end


    
  end  
end