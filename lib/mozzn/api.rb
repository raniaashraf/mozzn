require 'faraday'
require 'json'

module Mozzn
  class Api
    attr_accessor :connection
    attr_accessor :token
    
    def initialize token = nil
      @connection = Faraday.new('http://mozzn.com/api/v1/')
      @token = token
    end

    def get path, parms
      response = @connection.get uri(path), parms
      JSON.parse(response.body)
    end

    def post path, parms
      response = @connection.post uri(path), parms
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
