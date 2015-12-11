require 'spec_helper'

describe Keymaker::Configuration do

  context "with credentials provided" do
    let(:options) { { username: "jconnor", password: "easymoney" } }
    let(:config) do
      Keymaker::Configuration.new(options)
    end

    describe "#node_uri" do
      it "should not contain credentials" do
        expect(config.node_uri(42)).to_not include("jconnor:easymoney@")
      end
    end
  end

end
