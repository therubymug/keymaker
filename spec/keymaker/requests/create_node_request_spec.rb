require 'spec_helper'
require 'keymaker'

describe Keymaker::CreateNodeRequest, vcr: true do

  let(:create_node_request) { Keymaker::CreateNodeRequest.new(Keymaker.service, options).submit }
  let(:options) {{}}

  context "with properties" do
    let(:options) {{name: "John Connor"}}
    it "creates a node with the given properties" do
      create_node_request.body.should include(
        {"self"=>"http://localhost:7477/db/data/node/40", "data"=>{"name"=>"John Connor"}}
      )
    end
  end

  context "without properties" do
    it "creates an empty node" do
      create_node_request.body.should include(
        {"self"=>"http://localhost:7477/db/data/node/41", "data"=>{}}
      )
    end
  end

  it "returns a 201 status code" do
    create_node_request.status.should == 201
  end

  it "returns application/json" do
    create_node_request.faraday_response.headers["content-type"].should include("application/json")
  end

end
