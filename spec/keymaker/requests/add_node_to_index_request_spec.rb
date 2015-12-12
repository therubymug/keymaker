require 'spec_helper'
require 'keymaker'

describe Keymaker::AddNodeToIndexRequest, vcr: true do

  include_context "John and Sarah nodes"

  context "with valid options" do
    let(:options) {{index_name: "users", key: "email", node_id: john_node_id, value: john_email}}
    let(:add_node_to_index_request) { Keymaker::AddNodeToIndexRequest.new(Keymaker.service, options).submit }

    it "returns the Neo4j REST API starting point response request" do
      expect(add_node_to_index_request.body).to include(
        {
          "indexed"                      => "#{neo4j_host}/db/data/index/node/users/email/john%40resistance.net/#{john_node_id}",
          "outgoing_relationships"       => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/out",
          "data"                         => {"email" => "john@resistance.net"},
          "traverse"                     => "#{neo4j_host}/db/data/node/#{john_node_id}/traverse/{returnType}",
          "all_typed_relationships"      => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/all/{-list|&|types}",
          "property"                     => "#{neo4j_host}/db/data/node/#{john_node_id}/properties/{key}",
          "self"                         => "#{neo4j_host}/db/data/node/#{john_node_id}",
          "properties"                   => "#{neo4j_host}/db/data/node/#{john_node_id}/properties",
          "outgoing_typed_relationships" => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/out/{-list|&|types}",
          "incoming_relationships"       => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/in",
          "extensions"                   => {},
          "create_relationship"          => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships",
          "paged_traverse"               => "#{neo4j_host}/db/data/node/#{john_node_id}/paged/traverse/{returnType}{?pageSize,leaseTime}",
          "all_relationships"            => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/all",
          "incoming_typed_relationships" => "#{neo4j_host}/db/data/node/#{john_node_id}/relationships/in/{-list|&|types}"
        }
      )
    end

    it "returns a 201 status code" do
      expect(add_node_to_index_request.status).to eq(201)
    end

    it "returns application/json" do
      expect(add_node_to_index_request.faraday_response.headers["content-type"]).to include("application/json")
    end
  end

end
