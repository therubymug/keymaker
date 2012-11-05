require 'spec_helper'

describe Keymaker::CypherResult do

  describe ".initialize(columns, data)" do
    let(:cypher_result) { Keymaker::CypherResult.new(columns, result) }
    subject { cypher_result }
    context "given one column" do
      context "with its data as a hash" do
        let(:columns) { ["node"] }
        context "with neo4j attributes" do
          let(:result) do
            Hashie::Mash.new(
              data: {name: "John Connor"},
              self: "http://localhost/db/data/node/1337"
            )
          end
          its(:neo4j_id) { should == 1337 }
        end
        context "without neo4j attributes" do
          let(:result) { Hashie::Mash.new(data: {name: "John Connor"}) }
          its(:name) { should == "John Connor" }
        end
      end
      context "and its data is not a hash" do
        it "returns a Keymaker::CypherResult that responds to the column name with the value"
      end
    end
  end

end
