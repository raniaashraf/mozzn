require 'spec_helper'
require 'mozzn'

require 'aruba'
require 'aruba/api'

include Aruba::Api

def unique_name
	uuid = SecureRandom.uuid
  "APP#{uuid}"
end

def shell
    @shell ||= Thor::Shell::Basic.new
end

# Copied from: https://github.com/erikhuda/thor/blob/master/spec/helper.rb#L49
def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

describe Mozzn::Cli do
	before :each do
		@cli = Mozzn::Cli.new
	end

	describe "mozzn create_app" do
    describe "with valid params" do
      it "returns Application created successfuly" do
      	output = capture(:stdout) { @cli.create_app "#{unique_name}"}
      	expect(output).to match('Application created successfuly\nYou already have this remote.\n') 
      end
    end

    describe "with invalid params" do
      it "returns creating faild " do
      	output = capture(:stdout) { @cli.create_app "App name"}
      	expect(output).to match('creating faild\nYou already have this remote.\n')  
      end
    end

  end

  describe "mozzn add_key" do 
  	describe "with valid SSH key" do 
	  	it "returns SSH key created" do
	  		@cli.options = {public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXwZsqptW/1sxBvT6FAukbGsDKzqoBwwaAj6yUgM1ygdupF3NHhpf3huenu9X09SQTjvGDUjLCn6MgIREumrn3JaIEceqRVI5wtAd2c8S1kwJxZLYqTJT4iifW/ydTocz94FADwrLYWHIjlGLh/FY6xDHhloL0Ymvv+iiEg4cWhdC23zenEUOBS7khnw2FeXxLag4/tcinEYR1+Z3PrhRvfg964Rlf1BdspRwuF26GbiRqgo2M1bj9tBH5PZyL17R06adOpBAh1UzT8X9qSXi9OYE9C2HDIGH3MRpCdpJWU36FWqg8iG/DnFzlxzheRJ78A5R8WdDL2oMFE/BrkM9d'}
	  		output = capture(:stdout) { @cli.add_key }
	  		expect(output).to match('SSH key created')
	  	end
	  end

	  describe "with invalid SSH key" do
	  	it "returns SSH key created" do
	  		@cli.options = {public_key: 'invalid_public_key'}
	  		output = capture(:stdout) { @cli.add_key }
	  		expect(output).to match('creating faild')
	  	end
	  end

	  describe "with valid SSH key path" do
	  	it "returns SSH key created" do
	  		@cli.options = {key_path: '~/.ssh/id_rsa.pub'}
	  		output = capture(:stdout) { @cli.add_key }
	  		expect(output).to match('SSH key created')
	  	end
	  end

	  describe "with invalid SSH key path" do
	  	it "returns Unable to read /invalid_path, file does not exist or not accessible!" do
	  		@cli.options = {key_path: '/invalid_path'}
	  		output = capture(:stdout) { @cli.add_key }
	  		expect(output).to match('Unable to read /invalid_path, file does not exist or not accessible!')
	  	end
	  end
  end

  describe "mozzn login" do
  	describe "with valid params in interactive shell" do
  		it "returns logged in" do
  			pending
			end
		end

		describe "with invalid params in interactive shell" do
  		it "returns Error with your email or password" do
  			pending
			end
		end
  end



end