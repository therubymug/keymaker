require 'spec_helper'
require 'keymaker'

describe Keymaker::Service do

  include_context "John and Sarah nodes"

  describe "#get_node" do
    let(:get_node) { Keymaker.service.get_node(node_id) }
    context "with an existing node" do
      let(:node_id) { john_node_id }
      context "with properties" do
        it "responds to the node's properties" do
          get_node.should respond_to(:email)
        end
      end
    end
  end

end
