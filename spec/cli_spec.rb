require 'spec_helper'
require 'mozzn'



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
        expect { @cli.create_app }.to raise_error(Thor::Error, "You must enter application name.")
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
        expect { @cli.add_key }.to raise_error(Thor::Error, "Unable to read /invalid_path. File does not exist or not accessible.")
      end
    end

    describe "without params " do
      it "returns You must enter an SSH key path or a public SSH key!" do
        expect { @cli.add_key }.to raise_error(Thor::Error, "Neither a key path or an SSH key were provided. You must use -p or -k options.")
      end
    end
  end

  describe "mozzn login" do
    describe "with valid params " do
      it "returns Successfully logged in." do
        name = 'rania'
        email = unique_email
        password = '12345678'
        password_confirmation = '12345678'
        @cli.options = {
          name: name,
          email: email ,
          password: password,
          password_confirmation: password_confirmation
        }
        output = capture(:stdout) { @cli.registration }
        cli1 = Mozzn::Cli.new
        cli1.options = {
          email:email,
          password: password
        }
        expect{ @cli.login }.to raise_error(Thor::Error,"You have to confirm your account before continuing.")
      end
    end

    describe "with long_string email and password " do
      it "returns Invalid email or password." do
        @cli.options = {
          email: long_string,
          password: long_string
        }
        expect { @cli.login }.to raise_error(Thor::Error, "Invalid email or password.")
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

  describe "mozzn update" do
    describe "with avilable updates" do
      it "returns An update is available" do
        pending
      end
    end
    describe "with no avilable updates" do
      it "returns You have the latest version." do
        pending
      end
    end
  end

  describe "mozzn registration" do
    describe "with valid params" do
      it "returns Succesfully registered" do
        @cli.options = {
          name: 'rania',
          email: unique_email ,
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to match("Successfully registered")
      end
    end

    describe "with missing email" do
      it "should return email missing" do
        @cli.options = {
          name: 'rania',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /email/ 
      end
    end

    describe "with missing password" do
      it "should return password missing" do
        @cli.options = {
          name: 'rania',
          email: unique_name,
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password/ 
      end
    end

    describe "with missing confirmation Password" do
      it "should return password confirmation Missing" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/ 
      end
    end

    describe "with invalid email" do
      it "should return invalid email" do
        @cli.options = {
          name: 'rania',
          email: 'qqqqqqq',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /email/
      end
    end

    describe "with short password" do
      it "should short password" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '123',
          password_confirmation: '123'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password/
      end
    end

    describe "with unmatched password and confirmation password" do
      it "should return password and confirmation password are not matched" do
        @cli.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678',
          password_confirmation: '87654321'
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/
      end
    end

    describe "with nil parammeters" do
      it "should return Parameter Missing" do
        @cli.options = {
          name: nil,
          email: nil,
          password: nil,
          password_confirmation: nil
        }
        output = capture(:stdout) { @cli.registration }
        output.chomp!
        expect(output).to be =~ /email/
      end
    end
  end

  describe "mozzn resources" do
    describe "With valid params" do
      describe "With an existing App" do
        it "returns No assigned resources for this application." do
          capture(:stdout) { valid_user }
          appname =  valid_app 
          expect { @cli.resources "#{appname}" }.to raise_error(Thor::Error, "No assigned resources for this application.")
        end
      end

      describe "With an existing App having compnents and no datastores" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end
    
      describe "With an existing App having datastores and no components" do
        it "returns HTTP code 200:OK" do
          pending
        end
      end

      describe "With an existing App having no datastores or components" do
        it "returns No assigned resources for this application." do
          capture(:stdout) { valid_user }
          appname =  valid_app 
          expect { @cli.resources "#{appname}" }.to raise_error(Thor::Error, "No assigned resources for this application.")
        
        end
      end
    end
    describe "With invalid parameters" do
      describe "with not existing application" do
        it "Rais error 'Application not found'" do
          capture(:stdout) { valid_user }
          appname = 'AppName'
          expect { @cli.resources "#{appname}" }.to raise_error(Thor::Error, "Application does not found")
        end
      end

      describe "with unauthorized user" do
        it "returns HTTP code 422" do
          pending
        end
      end

      describe "without name" do
        it "should return Application name must be provided."  do 
          expect { @cli.resources }.to raise_error(Thor::Error, "You must enter Application Name!")
        end
      end
    end
  end
end