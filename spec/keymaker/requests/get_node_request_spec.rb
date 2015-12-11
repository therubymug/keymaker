require 'spec_helper'

describe Keymaker::GetNodeRequest do
  let(:get_node_request) { Keymaker::GetNodeRequest.new(Keymaker.service, opts).submit }

  context "with a non-existent node id" do
    let(:opts) {{node_id: 9999999942}}
    it "raises ResourceNotFound" do
      expect {
        get_node_request
      }.to raise_error(Keymaker::ResourceNotFound)
    end
  end

  context "with an empty node id" do
    let(:opts) {{}}
    it "raises ClientError" do
      expect {
        get_node_request
      }.to raise_error(Keymaker::ClientError)
    end
  end

end
