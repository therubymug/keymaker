require 'spec_helper'
require 'keymaker'

describe Keymaker::BatchRequest, :vcr => true do

  let(:batch_request) { Keymaker::BatchRequest.new(Keymaker.service, options).submit }

  context "when :to and :method are not set" do
    let(:options) do
      [ { foo: "WET", ot: "/node/1" } ]
    end
    it "raises BatchRequestError" do
      expect { batch_request }.to raise_error(Keymaker::BatchRequestError)
    end
  end

  context "when a resource is not found" do
    let(:options) do
      [ { method: "GET", to: "/node/999999999" } ]
    end
    it "raises BatchRequestError" do
      expect { batch_request }.to raise_error(Keymaker::BatchRequestError)
    end
  end

  context "with valid options" do
    let(:options) do
      [ {
        method: "POST",
        to: "/node",
        id: 0,
        body: {
          name: "John Connor"
        }
      }, {
        method: "POST",
        to: "/node",
        id: 1,
        body: {
          name: "Sarah Connor"
        }
      }, {
        method: "POST",
        to: "{0}/relationships",
        id: 3,
        body: {
          to: "{1}",
          data: {
            since: "1985"
          },
          type: "knows"
        }
      } ]
    end

    let(:results) do
      [ {"id"=>0,
         "location"=>"#{neo4j_host}/db/data/node/26",
         "body"=>{"outgoing_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/out",
                  "data"=>{"name"=>"John Connor"},
                  "traverse"=>"#{neo4j_host}/db/data/node/26/traverse/{returnType}",
                  "all_typed_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/all/{-list|&|types}",
                  "property"=>"#{neo4j_host}/db/data/node/26/properties/{key}",
                  "self"=>"#{neo4j_host}/db/data/node/26",
                  "properties"=>"#{neo4j_host}/db/data/node/26/properties",
                  "outgoing_typed_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/out/{-list|&|types}",
                  "incoming_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/in",
                  "extensions"=>{},
                  "create_relationship"=>"#{neo4j_host}/db/data/node/26/relationships",
                  "paged_traverse"=>"#{neo4j_host}/db/data/node/26/paged/traverse/{returnType}{?pageSize,leaseTime}",
                  "all_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/all",
                  "incoming_typed_relationships"=>"#{neo4j_host}/db/data/node/26/relationships/in/{-list|&|types}"},
                  "from"=>"/node"},
        {"id"=>1,
         "location"=>"#{neo4j_host}/db/data/node/27",
         "body"=>{"outgoing_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/out",
                  "data"=>{"name"=>"Sarah Connor"},
                  "traverse"=>"#{neo4j_host}/db/data/node/27/traverse/{returnType}",
                  "all_typed_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/all/{-list|&|types}",
                  "property"=>"#{neo4j_host}/db/data/node/27/properties/{key}",
                  "self"=>"#{neo4j_host}/db/data/node/27",
                  "properties"=>"#{neo4j_host}/db/data/node/27/properties",
                  "outgoing_typed_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/out/{-list|&|types}",
                  "incoming_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/in",
                  "extensions"=>{},
                  "create_relationship"=>"#{neo4j_host}/db/data/node/27/relationships",
                  "paged_traverse"=>"#{neo4j_host}/db/data/node/27/paged/traverse/{returnType}{?pageSize,leaseTime}",
                  "all_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/all",
                  "incoming_typed_relationships"=>"#{neo4j_host}/db/data/node/27/relationships/in/{-list|&|types}"},
                  "from"=>"/node"},
        {"id"=>3,
         "location"=>"#{neo4j_host}/db/data/relationship/2",
         "body"=>{"start"=>"#{neo4j_host}/db/data/node/26",
                  "data"=>{"since"=>"1985"},
                  "self"=>"#{neo4j_host}/db/data/relationship/2",
                  "property"=>"#{neo4j_host}/db/data/relationship/2/properties/{key}",
                  "properties"=>"#{neo4j_host}/db/data/relationship/2/properties",
                  "type"=>"knows",
                  "extensions"=>{},
                  "end"=>"#{neo4j_host}/db/data/node/27"},
                  "from"=>"#{neo4j_host}/db/data/node/26/relationships"}
      ]
    end

    it "runs the commands and returns their respective results" do
      batch_request.body.should == results
    end

    it "returns a 200 status code" do
      batch_request.status.should == 200
    end

  end

end
