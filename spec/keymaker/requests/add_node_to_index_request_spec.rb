require 'spec_helper'
require 'keymaker'

describe Keymaker::AddNodeToIndexRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:options) {{index_name: "users", key: "email", node_id: john_node_id, value: john_email}}
  let(:add_node_to_index_request) { Keymaker::AddNodeToIndexRequest.new(Keymaker.service, options).submit }

  it "returns the Neo4j REST API starting point response request" do
    add_node_to_index_request.body.should include(
      {
        "indexed"                      => "http://localhost:7477/db/data/index/node/users/email/john%40resistance.net/1004",
        "outgoing_relationships"       => "http://localhost:7477/db/data/node/1004/relationships/out",
        "data"                         => {"email" => "john@resistance.net"},
        "traverse"                     => "http://localhost:7477/db/data/node/1004/traverse/{returnType}",
        "all_typed_relationships"      => "http://localhost:7477/db/data/node/1004/relationships/all/{-list|&|types}",
        "property"                     => "http://localhost:7477/db/data/node/1004/properties/{key}",
        "self"                         => "http://localhost:7477/db/data/node/1004",
        "properties"                   => "http://localhost:7477/db/data/node/1004/properties",
        "outgoing_typed_relationships" => "http://localhost:7477/db/data/node/1004/relationships/out/{-list|&|types}",
        "incoming_relationships"       => "http://localhost:7477/db/data/node/1004/relationships/in",
        "extensions"                   => {},
        "create_relationship"          => "http://localhost:7477/db/data/node/1004/relationships",
        "paged_traverse"               => "http://localhost:7477/db/data/node/1004/paged/traverse/{returnType}{?pageSize,leaseTime}",
        "all_relationships"            => "http://localhost:7477/db/data/node/1004/relationships/all",
        "incoming_typed_relationships" => "http://localhost:7477/db/data/node/1004/relationships/in/{-list|&|types}"
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
