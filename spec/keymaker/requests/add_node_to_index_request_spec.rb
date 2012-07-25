require 'spec_helper'
require 'keymaker'

describe Keymaker::AddNodeToIndexRequest, vcr: true do

  include_context "John and Sarah nodes"

  context "with valid options" do
    let(:options) {{index_name: "users", key: "email", node_id: john_node_id, value: john_email}}
    let(:add_node_to_index_request) { Keymaker::AddNodeToIndexRequest.new(Keymaker.service, options).submit }

    it "returns the Neo4j REST API starting point response request" do
      add_node_to_index_request.body.should include(
        {
          "indexed"                      => "#{neo4j_host}/db/data/index/node/users/email/john%40resistance.net/189",
          "outgoing_relationships"       => "#{neo4j_host}/db/data/node/189/relationships/out",
          "data"                         => {"email" => "john@resistance.net"},
          "traverse"                     => "#{neo4j_host}/db/data/node/189/traverse/{returnType}",
          "all_typed_relationships"      => "#{neo4j_host}/db/data/node/189/relationships/all/{-list|&|types}",
          "property"                     => "#{neo4j_host}/db/data/node/189/properties/{key}",
          "self"                         => "#{neo4j_host}/db/data/node/189",
          "properties"                   => "#{neo4j_host}/db/data/node/189/properties",
          "outgoing_typed_relationships" => "#{neo4j_host}/db/data/node/189/relationships/out/{-list|&|types}",
          "incoming_relationships"       => "#{neo4j_host}/db/data/node/189/relationships/in",
          "extensions"                   => {},
          "create_relationship"          => "#{neo4j_host}/db/data/node/189/relationships",
          "paged_traverse"               => "#{neo4j_host}/db/data/node/189/paged/traverse/{returnType}{?pageSize,leaseTime}",
          "all_relationships"            => "#{neo4j_host}/db/data/node/189/relationships/all",
          "incoming_typed_relationships" => "#{neo4j_host}/db/data/node/189/relationships/in/{-list|&|types}"
        }
      )
    end

    it "returns a 201 status code" do
      add_node_to_index_request.status.should == 201
    end

    it "returns application/json" do
      add_node_to_index_request.faraday_response.headers["content-type"].should include("application/json")
    end
  end

end
