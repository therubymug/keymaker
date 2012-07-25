require 'spec_helper'

describe Keymaker::DeleteRelationshipRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:delete_relationship_request) { Keymaker::DeleteRelationshipRequest.new(Keymaker.service, options).submit }

  context "with an existing relationship" do
    let(:relationship_id) { Keymaker::CreateRelationshipRequest.new(Keymaker.service, rel_opts).submit.neo4j_id }
    let(:rel_opts) { { node_id: sarah_node_id, end_node_id: john_node_id, rel_type: "birthed", data: {location: "unknown", date: "1985-02-28"} } }

    let(:options) { {relationship_id: relationship_id} }
    it "deletes the relationship" do
      delete_relationship_request.status.should == 204
    end
  end

  context "with a non-existent relationship" do
    let(:options) { {relationship_id: 9000000009} }
    it "raises ResourceNotFound" do
      expect {
        delete_relationship_request
      }.to raise_error(Keymaker::ResourceNotFound)
    end
  end

end
