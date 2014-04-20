require 'faraday'
require 'json'
require 'mozzn/exceptions'

module Mozzn
  class Api
    attr_accessor :connection
    attr_accessor :token
    
    def initialize token = nil
      if ENV['GEM_ENV'] == 'test'
        @connection = Faraday.new('http://localhost:3000/api/v1/')
      else
        @connection = Faraday.new('http://localhost:3000/api/v1/')
      end
      @token = token
    end

    def get path, parms
      begin
        response = @connection.get uri(path), parms
      rescue Faraday::Error::ConnectionFailed => e
        raise Mozzn::Disconnected
      end
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError => e
        raise Mozzn::UnexpectedOutput
      end
      
    end

    def post path, parms
      begin
        response = @connection.post uri(path), parms
      rescue Faraday::Error::ConnectionFailed => e
        raise Mozzn::Disconnected
      end
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError => e
        raise Mozzn::UnexpectedOutput
      end
      
    end


    private
    def uri path
      uri = []
      uri << path.to_s
      uri << "auth_token=#{@token}" unless @token.nil?
      uri.join('?')
    end
  end
end
