require 'spec_helper'
require 'keymaker'

describe Keymaker::CreateNodeRequest, vcr: true do

  let(:response) { Keymaker::CreateNodeRequest.new(Keymaker.service, options).submit }
  let(:options) {{}}
  let(:node_id) { response.neo4j_id }
  let(:faraday_response) { response.faraday_response }
  let(:status) { response.status }
  let(:body) { response.body }

  context "with properties" do
    let(:options) {{name: "John Connor"}}
    it "creates a node with the given properties" do
      body.should include({
        "self" => "#{neo4j_host}/db/data/node/#{node_id}",
        "data" => {"name"=>"John Connor"}
      })
    end
  end

  context "without properties" do
    it "creates an empty node" do
      body.should include({
        "self" => "#{neo4j_host}/db/data/node/#{node_id}",
        "data"=>{}
      })
    end
  end

  it "returns a 201 status code" do
    status.should == 201
  end

  it "returns application/json" do
    faraday_response.headers["content-type"].should include("application/json")
  end

end
