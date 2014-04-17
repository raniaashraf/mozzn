
require 'rubygems'
require 'thor'

class Cli < Thor
  namespace       "talk"

  desc      "greet", "says hello"
  def greet
    puts "Hello!"
  end

  class Formal < Thor
    namespace "talk:formal"

    desc    "greet", "says a formal hello"
    def greet
      puts "Good evening!"
    end
  end

end

Cli.start