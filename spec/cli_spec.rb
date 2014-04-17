require 'spec_helper'
require 'mozzn'

describe Mozzn::Cli do
  before :each do
    @cli = Mozzn::Cli.new
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

end