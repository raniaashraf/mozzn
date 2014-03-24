require 'faraday'
require 'json'

module Mozzn
  class Api
    attr_accessor :connection
    
    def initialize 
      @connection = Faraday.new('http://localhost:3000/api/v1/')
    end

    def get path , parms
      response = @connection.get "#{path.to_s}", parms
      JSON.parse(response.body)
    end

    def post path , parms
      response = @connection.post "#{path.to_s}", parms
      JSON.parse(response.body)
    end
  end
end
