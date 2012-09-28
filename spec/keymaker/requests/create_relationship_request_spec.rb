require 'spec_helper'
require 'keymaker'

describe Keymaker::CreateRelationshipRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:response) { Keymaker::CreateRelationshipRequest.new(Keymaker.service, options).submit }
  let(:node_id) { response.neo4j_id }
  let(:faraday_response) { response.faraday_response }
  let(:status) { response.status }
  let(:body) { response.body }

  context "with properties" do
    let(:options) do
      {
        node_id: sarah_node_id,
        end_node_id: john_node_id,
        rel_type: "birthed",
        data: {location: "unknown", date: "1985-02-28"}
      }
    end

    it "creates a relationship with the given properties" do
      body.should include({
        "self" => "#{neo4j_host}/db/data/relationship/#{node_id}",
        "data" => {"location"=>"unknown", "date"=>"1985-02-28"},
        "type" => "birthed"
      })
    end

    it "returns a 201 status code" do
      status.should == 201
    end

    it "returns application/json" do
      faraday_response.headers["content-type"].should include("application/json")
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
      body.should include({
        "self" => "#{neo4j_host}/db/data/relationship/#{node_id}",
        "data"=>{},
        "type"=>"birthed"
      })
    end
  end

  context "with invalid options" do
    let(:options) {{}}
    it "raises ClientError" do
      expect { response }.to raise_error(Keymaker::ClientError)
    end
  end

end
