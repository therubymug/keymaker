require 'spec_helper'

describe Keymaker::CypherStruct do

  subject { Keymaker::CypherStruct.new(columns, result) }

  context "when result is an array" do
  end

  context "when result is a string" do
  end

  context "when result is a hash" do

    context "and it contains a 'self' key" do

      let(:columns) { "n" }
      let(:result) do
        Hashie::Mash.new({data:{name:"T1000"}, self:"http://localhost/db/data/node/310"})
      end

      its(:name) { should == "T1000" }
      its(:neo4j_id) { should == 310 }

    end

    context "and it does not contain a 'self' key" do

      let(:columns) { ["neo4j_id", "name"] }
      let(:result) { [310, "T1000"] }

      its(:name) { should == "T1000" }
      its(:neo4j_id) { should == 310 }

    end

  end

end
