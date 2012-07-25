require 'spec_helper'

describe Keymaker::ExecuteCypherRequest, vcr: true do

  let(:execute_cypher_request) { Keymaker::ExecuteCypherRequest.new(Keymaker.service, opts).submit }

  context "with a valid Cypher Query" do
    let(:opts) { {query: "CREATE (n {name : 'John Connor'}) RETURN n;"} }
    it "returns a 200 status code" do
      execute_cypher_request.status.should == 200
    end
  end

  context "with an invalid Cypher Query" do
    let(:opts) { {query: "START ME UP"} }
    it "raises ClientError" do
      expect {
        execute_cypher_request
      }.to raise_error(Keymaker::ClientError)
    end
  end

end
