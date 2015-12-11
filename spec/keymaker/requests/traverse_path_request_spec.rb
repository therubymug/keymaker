require 'spec_helper'

describe Keymaker::TraversePathRequest, vcr: true do

  include_context "John and Sarah nodes"

  let(:traverse_path_request) { Keymaker::TraversePathRequest.new(Keymaker.service, options) }

  def do_it
    traverse_path_request.submit
  end

  describe "#traverse_path_properties" do
    context "with options" do
      let(:options) { {order: "depth_first", relationships: "out"} }
      it "builds the query properties with defaults" do
        expect(traverse_path_request.traverse_path_properties).to include(
          order: "depth_first",
          relationships: "out",
          uniqueness: "relationship_global"
        )
      end
    end
  end

  context "with valid options" do
    before do
      Keymaker.service.create_relationship("birthed", sarah_node_id, john_node_id)
    end
    let(:options) do
      { max_depth: 1,
        node_id: john_node_id,
        order: "breadth_first",
        relationships: [{"direction" => "all", "type" => "birthed"}],
        return_filter: {"language" => "builtin", "name" => "all"},
        uniqueness: "relationship_global" }
    end
    it "returns status code 200" do
      expect(do_it.status).to eq(200)
    end
  end

  context "with invalid options" do
    let(:options) {{node_id: -11111111111111}}
    it "raise a ClientError" do
      expect { do_it }.to raise_error(Keymaker::ClientError)
    end
  end

end
