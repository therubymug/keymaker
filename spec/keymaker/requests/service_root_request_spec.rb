require 'spec_helper'
require 'keymaker'

describe Keymaker::ServiceRootRequest do

  let(:service_root_request) { Keymaker::ServiceRootRequest.new(Keymaker.service, {}).submit }

  it "returns the Neo4j REST API starting point response request" do
    expect(service_root_request.body).to include(
      {
        "cypher"             => "#{neo4j_host}/db/data/cypher",
        "relationship_index" => "#{neo4j_host}/db/data/index/relationship",
        "node"               => "#{neo4j_host}/db/data/node",
        "relationship_types" => "#{neo4j_host}/db/data/relationship/types",
        "batch"              => "#{neo4j_host}/db/data/batch",
        "extensions_info"    => "#{neo4j_host}/db/data/ext",
        "node_index"         => "#{neo4j_host}/db/data/index/node",
        "extensions"         => {}
      }
    )
  end

  it "returns a 200 status code" do
    expect(service_root_request.status).to eq(200)
  end

  it "returns application/json" do
    expect(service_root_request.faraday_response.headers["content-type"]).to include("application/json")
  end

end
