require 'spec_helper'

describe Keymaker::UpdateNodePropertiesRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:update_node_properties_request) { Keymaker::UpdateNodePropertiesRequest.new(Keymaker.service, options) }

  describe "#node_properties" do
    let(:options) do
      {node_id: john_node_id, email: "john.connor@resistance.net"}
    end
    it "excludes the node_id" do
      update_node_properties_request.node_properties.should_not include({node_id: john_node_id})
    end
  end

  def do_it
    update_node_properties_request.submit
  end

  context "with valid options" do
    let(:options) do
      {node_id: john_node_id, email: "john.connor@resistance.net"}
    end
    let(:john_node_query) {  {query: "START n=node({node_id}) RETURN n.email;", params: {node_id: john_node_id.to_i}} }
    let(:john_node_cypher_request) { Keymaker::ExecuteCypherRequest.new(Keymaker.service, john_node_query).submit }
    let(:john_node_email) { john_node_cypher_request.body["data"][0][0] }

    it "returns a status of 204" do
      do_it.status.should == 204
    end

    it "updates the properties" do
      do_it
      john_node_email.should == "john.connor@resistance.net"
    end

  end

  context "with invalid options" do
    let(:options) { {node_id: -1} }
    it "raises a ClientError" do
      expect {
        do_it
      }.to raise_error(Keymaker::ClientError)
    end
  end

end
