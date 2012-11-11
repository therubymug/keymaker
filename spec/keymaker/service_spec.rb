require 'spec_helper'
require 'keymaker'

describe Keymaker::Service do

  include_context "John and Sarah nodes"

  let(:node_id) { john_node_id }
  let(:get_node) { Keymaker.service.get_node(node_id) }

  describe "#get_node" do
    context "with an existing node" do
      context "with properties" do
        it "responds to the node's properties" do
          get_node.should respond_to(:email)
        end
      end
    end
  end

  describe "#delete_node" do
    let(:delete_node) { Keymaker.service.delete_node(node_id) }
    context "with an existing node" do
      it "deletes the node" do
        delete_node
        expect { get_node }.to raise_error(Keymaker::ResourceNotFound)
      end
    end
  end

  context "with credentials provided" do
    let(:options) { { username: "jconnor", password: "easymoney" } }
    let(:config) do
      Keymaker::Configuration.new(options)
    end
    let(:service) { Keymaker::Service.new(config) }

    describe "#connection" do
      it "includes the username and password" do
        Faraday.should_receive(:new).with(url: config.connection_service_root_url)
        service.connection
      end
    end
  end

end
