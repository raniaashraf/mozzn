require 'spec_helper'
require 'mozzn'
require "mozzn/commands/key"

describe Mozzn::Commands::Key do
  before :each do
    @key = Mozzn::Commands::Key.new
  end
  describe "mozzn add_key" do 
    describe "with valid SSH key" do 
      it "returns SSH key created"  do
        capture(:stdout) { valid_user }
        @key.options = {public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDXwZsqptW/1sxBvT6FAukbGsDKzqoBwwaAj6yUgM1ygdupF3NHhpf3huenu9X09SQTjvGDUjLCn6MgIREumrn3JaIEceqRVI5wtAd2c8S1kwJxZLYqTJT4iifW/ydTocz94FADwrLYWHIjlGLh/FY6xDHhloL0Ymvv+iiEg4cWhdC23zenEUOBS7khnw2FeXxLag4/tcinEYR1+Z3PrhRvfg964Rlf1BdspRwuF26GbiRqgo2M1bj9tBH5PZyL17R06adOpBAh1UzT8X9qSXi9OYE9C2HDIGH3MRpCdpJWU36FWqg8iG/DnFzlxzheRJ78A5R8WdDL2oMFE/BrkM9d'}
        output = capture(:stdout) { @key.add }
        expect(output).to match('SSH key created')
      end
    end

    describe "with invalid SSH key" do
      it "returns SSH key created" do
        capture(:stdout) { valid_user }
        @key.options = {public_key: 'invalid_public_key'}
        output = capture(:stdout) { @key.add }
        expect(output).to match('creating faild')
      end
    end

    describe "with valid SSH key path" do
      it "returns SSH key created" do
        capture(:stdout) { valid_user }
        @key.options = {key_path: '~/.ssh/id_rsa.pub'}
        output = capture(:stdout) { @key.add }
        expect(output).to match('SSH key created')
      end
    end

    describe "with invalid SSH key path" do
      it "returns Unable to read /invalid_path, file does not exist or not accessible!" do
        capture(:stdout) { valid_user }
        @key.options = {key_path: '/invalid_path'}
        expect { @key.add }.to raise_error(Thor::Error, "Unable to read /invalid_path. File does not exist or not accessible.")
      end
    end

    describe "without params " do
      it "returns You must enter an SSH key path or a public SSH key!" do
        capture(:stdout) { valid_user }
        expect { @key.add }.to raise_error(Thor::Error, "Neither a key path or an SSH key were provided. You must use -p or -k options.")
      end
    end
  end

  describe "mozzn key list" do
    describe "With valid params" do
      describe "With an existing keys" do
        it "returns Your keys are:" do
          capture(:stdout) { valid_user }
          output = capture(:stdout) { @key.list }
          expect(output).to be =~ /Your SSH keys are:/  
        end
      end

      describe "With no existing Apps" do
        it "returns You don't have any SSH key yet." do
          capture(:stdout) { valid_user2 } 
          output = capture(:stdout) { @key.list }
          expect(output).to be =~ /You don't have any SSH key yet./ 
        end
      end
    end
  end

  describe "mozzn key destroy" do
    describe "with valid params" do
      it " returns Key deleted." do
        pending
      end
    end

    describe "with invalid params" do
      it " returns Key did not deleted." do
        pending
      end
    end
  end
end
