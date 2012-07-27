require 'spec_helper'

describe Keymaker::ExecuteGremlinRequest, vcr: true do

  let(:execute_gremlin_request) { Keymaker::ExecuteGremlinRequest.new(Keymaker.service, opts).submit }

  context "with a valid Gremlin Script" do
    let(:opts) { {script: "g.V();"} }
    it "returns a 200 status code" do
      execute_gremlin_request.status.should == 200
    end
  end

  context "with an invalid Gremlin Script" do
    let(:opts) { {script: "START ME UP"} }
    it "raises ClientError" do
      expect {
        execute_gremlin_request
      }.to raise_error(Keymaker::ClientError)
    end
  end

end
