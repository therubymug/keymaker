require 'spec_helper'

describe Keymaker::Service  do

  context "with credentials provided" do
    let(:options) { { username: "jconnor", password: "easymoney" } }
    let(:config) do
      Keymaker::Configuration.new(options)
    end
    let(:service) { Keymaker::Service.new(config) }

    describe "#connection" do
      it "includes the username and password" do
        expect(Faraday).to receive(:new).with(url: config.connection_service_root_url)
        service.connection
      end
    end
  end

end
