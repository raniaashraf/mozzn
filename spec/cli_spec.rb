require 'spec_helper'
require 'mozzn'

def unique_name
  uuid = SecureRandom.uuid
  "APP#{uuid}"
end

describe Mozzn::Cli do
  before :each do
    @cli = Mozzn::Cli.new
  end

  describe "mozzn create_app" do
    describe "with valid params" do
      it "returns Application created successfuly" do
        output = capture(:stdout) { @cli.create_app "#{unique_name}"}
        one,two = output.split("\n")
        expect(one).to match('Application created successfuly') 
      end
    end

    describe "with invalid params" do
      it "returns creating faild " do
        output = capture(:stdout) { @cli.create_app "App name"}
        one,two = output.split("\n")
        expect(one).to match('creating faild')  
      end
    end

    describe "without params " do
      it "returns You must enter Application Name! " do
        expect { @cli.create_app }.to raise_error(Thor::Error, "You must enter Application Name!")
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
        expect { @cli.add_key }.to raise_error(Thor::Error, "Unable to read /invalid_path, file does not exist or not accessible!")
      end
    end

    describe "without params " do
      it "returns You must enter an SSH key path or a public SSH key!" do
        expect { @cli.add_key }.to raise_error(Thor::Error, "You must enter an SSH key path or a public SSH key!")
      end
    end
  end

  describe "mozzn login" do
    describe "with valid params " do
      it "returns Successfully logged in." do
        @cli.options = {
          email: 'rania@overcstudios.com',
          password: '12345678'
        }
        output = capture(:stdout) { @cli.login }
        output.chomp!
        expect(output).to match("Successfully logged in.")
      end
    end

    describe "with invalid params " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: 'invalid@example.com',
          password: '12345678'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "with nil params " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: '',
          password: ''
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "without email " do
      it "returns Email and password must be provided! " do
        @cli.options = {
          password: '12345678'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "without password " do
      it "returns Email and password must be provided! " do
        @cli.options = {
          email: 'rania@overcstudios.com'
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "with no params " do
      it "returns an interactive shell asking for email and password" do
        pending
      end
    end

  end



end