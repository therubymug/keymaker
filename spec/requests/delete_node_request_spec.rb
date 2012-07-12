require 'spec_helper'

describe Keymaker::DeleteNodeRequest do

  let(:delete_node_request) { Keymaker::DeleteNodeRequest.new(Keymaker.service, opts).submit }

  context "with a node without relationships" do
    let(:node_id) { Keymaker.service.create_node({name: "John Connor"}).neo4j_id }
    let(:opts) { {node_id: node_id} }
    it "deletes the node" do
      delete_node_request.status.should == 204
    end
  end

  context "with a node with relationships" do
    let(:john) { Keymaker.service.create_node({name: "John Connor"}) }
    let(:john_id) { john.neo4j_id }
    let(:sarah) { Keymaker.service.create_node({name: "Sarah Connor"}) }
    let!(:relationship) { Keymaker.service.create_relationship("knows", john_id, sarah.neo4j_id) }
    let(:opts) { {node_id: john_id} }
    it "does not delete the node" do
      expect {
        delete_node_request
      }.to raise_error(Keymaker::ConflictError)
    end
  end

  context "with a non-existent node" do
    let(:opts) { {node_id: 9000000009} }
    it "raises ResourceNotFound" do
      expect {
        delete_node_request
      }.to raise_error(Keymaker::ResourceNotFound)
    end
  end

end
