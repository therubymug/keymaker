require 'spec_helper'
require 'keymaker'

describe Keymaker::GetRelationshipTypesRequest, vcr: true do

  let(:get_relationship_types_request) { Keymaker::GetRelationshipTypesRequest.new(Keymaker.service, {}).submit }

  context "with existing relationships" do
    include_context "John and Sarah nodes"
    before do
      Keymaker.service.create_relationship(:loves, john_node_id, sarah_node_id).neo4j_id
    end
    it "returns a unique array of relationship types" do
      get_relationship_types_request.body.should == ["loves", "knows"]
    end
  end
end
