require 'spec_helper'
require 'keymaker'

describe Keymaker::ServiceRootRequest, vcr: true do

  let(:service_root_request) { Keymaker::ServiceRootRequest.new(Keymaker.service, {}).submit }

  it "returns the Neo4j REST API starting point response request" do
    service_root_request.body.should include(
      {
        "cypher"             => "#{neo4j_host}/db/data/cypher",
        "relationship_index" => "#{neo4j_host}/db/data/index/relationship",
        "node"               => "#{neo4j_host}/db/data/node",
        "relationship_types" => "#{neo4j_host}/db/data/relationship/types",
        "batch"              => "#{neo4j_host}/db/data/batch",
        "extensions_info"    => "#{neo4j_host}/db/data/ext",
        "node_index"         => "#{neo4j_host}/db/data/index/node",
        "extensions"         =>
        {
          "CypherPlugin"   => {"execute_query"  => "#{neo4j_host}/db/data/ext/CypherPlugin/graphdb/execute_query"},
          "GremlinPlugin"  => {"execute_script" => "#{neo4j_host}/db/data/ext/GremlinPlugin/graphdb/execute_script"}
        }
      }
    )
  end

  it "returns a 200 status code" do
    service_root_request.status.should == 200
  end

  it "returns application/json" do
    service_root_request.faraday_response.headers["content-type"].should include("application/json")
  end

end
