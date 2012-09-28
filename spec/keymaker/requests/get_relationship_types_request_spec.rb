require 'spec_helper'
require 'keymaker'

describe Keymaker::GetRelationshipTypesRequest, vcr: true do

  let(:get_relationship_types_request) { Keymaker::GetRelationshipTypesRequest.new(Keymaker.service, {}).submit }

  context "with existing relationships" do
    include_context "John and Sarah nodes"
    it "returns a unique array of relationship types" do
      Keymaker.service.create_relationship(:loves, john_node_id, sarah_node_id)
      get_relationship_types_request.body.should include("loves", "knows")
    end
  end

end
