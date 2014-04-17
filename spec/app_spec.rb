require 'spec_helper'

describe Mozzn::Commands::App do
  before :each do
    @app = Mozzn::Commands::App.new
  end
  describe "mozzn create_app" do
    describe "with valid params" do
      it "returns Application created successfuly" do
        capture(:stdout) { valid_user }
        output = capture(:stdout) { @app.create "#{unique_name}" }
        one,two = output.split("\n")
        expect(one).to match('Application created successfuly') 
      end
    end
    describe "with invalid params" do
      it "returns creating faild " do
        capture(:stdout) { valid_user }
        output = capture(:stdout) { @app.create "App name"}
        one,two = output.split("\n")
        expect(one).to match('creating faild')  
      end
    end

    describe "without params " do
      it "returns You must enter Application Name! " do
        expect { @app.create }.to raise_error(Thor::Error, "You must enter application name.")
      end
    end
  end
  describe "mozzn resources" do
    describe "With valid params" do
      describe "With an existing App" do
        it "returns No assigned resources for this application." do
          capture(:stdout) { valid_user }
          appname =  valid_app 
          expect { @app.resources "#{appname}" }.to raise_error(Thor::Error, "No assigned resources for this application.")
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
          expect { @app.resources "#{appname}" }.to raise_error(Thor::Error, "No assigned resources for this application.")
        
        end
      end
    end
    describe "With invalid parameters" do
      describe "with not existing application" do
        it "Rais error 'Application not found'" do
          capture(:stdout) { valid_user }
          appname = 'AppName'
          expect { @app.resources "#{appname}" }.to raise_error(Thor::Error, "Application was not found")
        end
      end

      describe "with unauthorized user" do
        it "returns HTTP code 422" do
          pending
        end
      end

      describe "without name" do
        it "should return Application name must be provided." do 
          expect { @app.resources }.to raise_error(Thor::Error, "You must enter Application Name!")
        end
      end
    end
  end
end