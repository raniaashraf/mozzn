require 'faraday'
require 'json'
require 'mozzn/exceptions'

module Mozzn
  class Api
    attr_accessor :connection
    attr_accessor :token
    
    def initialize token = nil
      @connection = Faraday.new('http://localhost:3000/api/v1/')
      @token = token
    end

    def get path, parms
      response = @connection.get uri(path), parms
      rescue Faraday::Error::ConnectionFailed
        raise Mozzn::Disconnected
      JSON.parse(response.body)
    end

    def post path, parms
      response = @connection.post uri(path), parms
      rescue Faraday::Error::ConnectionFailed
        raise Mozzn::Disconnected
      JSON.parse(response.body)
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
