require 'spec_helper'
require 'keymaker'

describe Keymaker::BatchGetNodesRequest do

  describe "#build_opts_collection" do

    let(:node_ids) { [1,2,3,4] }
    let(:batch_get_nodes_request) do
      Keymaker::BatchGetNodesRequest.new(Keymaker.service, node_ids)
    end

    it "builds the job descriptions collection" do
      batch_get_nodes_request.opts.should == [
        {id: 0, to: "http://localhost:7477/db/data/node/1", method: "GET"},
        {id: 1, to: "http://localhost:7477/db/data/node/2", method: "GET"},
        {id: 2, to: "http://localhost:7477/db/data/node/3", method: "GET"},
        {id: 3, to: "http://localhost:7477/db/data/node/4", method: "GET"}
      ]
    end

  end
end
