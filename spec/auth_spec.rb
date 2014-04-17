require 'spec_helper'

describe Mozzn::Commands::Auth do
  before :each do
    @auth = Mozzn::Commands::Auth.new
  end
  describe "mozzn login" do
    describe "with valid params " do
      it "returns Successfully logged in." do
        @auth.options = {
          email:'test@mozzn.com',
          password: '12345678'
        }
        output = capture(:stdout) { @auth.login }
        one,two = output.split("\n")
        expect(one).to match('Signed in successfully.')
      end
    end

    describe "with long_string email and password " do
      it "returns Long email or password." do
        @auth.options = {
          email: long_string,
          password: long_string
        }
        expect { @auth.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "with invalid params " do
      it "returns Invalid email or password." do
        @auth.options = {
          email: 'invalid@example.com',
          password: '12345678'
        }
        expect { @auth.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "with nil params " do
      it "returns Invalid email or password." do
        @auth.options = {
          email: '',
          password: ''
        }
        expect { @auth.login }.to raise_error(Thor::Error, "Invalid email or password.")
      end
    end

    describe "without email " do
      it "returns Email and password must be provided! " do
        @auth.options = {
          password: '12345678'
        }
        expect { @auth.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "without password " do
      it "returns Email and password must be provided! " do
        @auth.options = {
          email: 'rania@overcstudios.com'
        }
        expect { @auth.login }.to raise_error(Thor::Error, "Email and password must be provided!")
      end
    end

    describe "with no params " do
      it "returns an interactive shell asking for email and password" do
        pending
      end
    end
  end
  describe "mozzn registration" do
    describe "with valid params" do
      it "returns Succesfully registered" do
        @auth.options = {
          name: 'rania',
          email: unique_email ,
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to match("Successfully registered")
      end
    end

    describe "with missing email" do
      it "should return email missing" do
        @auth.options = {
          name: 'rania',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /email/ 
      end
    end

    describe "with missing password" do
      it "should return password missing" do
        @auth.options = {
          name: 'rania',
          email: unique_name,
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /password/ 
      end
    end

    describe "with missing confirmation Password" do
      it "should return password confirmation Missing" do
        @auth.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/ 
      end
    end

    describe "with invalid email" do
      it "should return invalid email" do
        @auth.options = {
          name: 'rania',
          email: 'qqqqqqq',
          password: '12345678',
          password_confirmation: '12345678'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /email/
      end
    end

    describe "with short password" do
      it "should short password" do
        @auth.options = {
          name: 'rania',
          email: unique_email,
          password: '123',
          password_confirmation: '123'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /password/
      end
    end

    describe "with unmatched password and confirmation password" do
      it "should return password and confirmation password are not matched" do
        @auth.options = {
          name: 'rania',
          email: unique_email,
          password: '12345678',
          password_confirmation: '87654321'
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be  =~ /password_confirmation/
      end
    end

    describe "with nil parammeters" do
      it "should return Parameter Missing" do
        @auth.options = {
          name: nil,
          email: nil,
          password: nil,
          password_confirmation: nil
        }
        output = capture(:stdout) { @auth.register }
        output.chomp!
        expect(output).to be =~ /email/
      end
    end
  end
end