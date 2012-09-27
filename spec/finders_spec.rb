require 'spec_helper'
require 'keymaker'
require 'neo4j-cypher'

describe Keymaker::Finders do

  include_context "John and Sarah nodes"

  describe "#find" do

    subject do
      Keymaker::Node.find(id)
    end

    let(:id) { john_node_id }

    it "should build the appropriate cypher query" do
      Keymaker.service.should_receive(:execute_cypher).with("START v1=node(#{john_node_id}) RETURN v1")
      subject
    end

    it "should return the node" do
      subject.first.email.should == john_email
    end

  end
end

