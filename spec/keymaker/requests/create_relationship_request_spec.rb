require 'spec_helper'
require 'keymaker'

describe Keymaker::CreateRelationshipRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:create_relationship_request) { Keymaker::CreateRelationshipRequest.new(Keymaker.service, options).submit }

  context "with properties" do
    let(:options) do
      {
        node_id: sarah_node_id,
        end_node_id: john_node_id,
        rel_type: "birthed",
        data: {location: "unknown", date: "1985-02-28"}
      }
    end

    it "creates a node with the given properties" do
      create_relationship_request.body.should include(
        {"self"=>"#{neo4j_host}/db/data/relationship/18", "data"=>{"location"=>"unknown", "date"=>"1985-02-28"}, "type"=>"birthed"}
      )
    end

    it "returns a 201 status code" do
      create_relationship_request.status.should == 201
    end

    it "returns application/json" do
      create_relationship_request.faraday_response.headers["content-type"].should include("application/json")
    end

  end

  context "without properties" do
    let(:options) do
      {
        node_id: sarah_node_id,
        end_node_id: john_node_id,
        rel_type: "birthed"
      }
    end
    it "creates an empty relationship of type: 'birthed'" do
      create_relationship_request.body.should include(
        {"self"=>"#{neo4j_host}/db/data/relationship/21", "data"=>{}, "type"=>"birthed"}
      )
    end
  end

  context "with invalid options" do
    let(:options) {{}}
    it "raises ClientError" do
      expect { create_relationship_request }.to raise_error(Keymaker::ClientError)
    end
  end

end
