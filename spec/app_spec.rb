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
        expect { @app.create "App name" }.to raise_error(Thor::Error, "creating faild")
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
        it "returns No assigned resources for this application.", focused: true do
          capture(:stdout) { valid_user }
          name = valid_app
          @app.options = {
          appname: name
          }
          expect { @app.resources }.to raise_error(Thor::Error, "No assigned resources for this application.")
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
        it "returns No assigned resources for this application.", focused: true do
          capture(:stdout) { valid_user }
          name = valid_app
          @app.options = {
          appname: name
          }
          expect { @app.resources }.to raise_error(Thor::Error, "No assigned resources for this application.") 
        end
      end
    end
    describe "With invalid parameters" do
      describe "with unauthorized user" do
        it "returns HTTP code 422" do
          pending
        end
      end
    end
  end
end