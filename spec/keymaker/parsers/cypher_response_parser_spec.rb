require 'spec_helper'

describe Keymaker::CypherResponseParser do

  describe ".parse(response_body)" do

    subject { Keymaker::CypherResponseParser.parse(response_body) }

    context "when there's only one column in the results" do

      context "and the results are hashes" do
        let(:results) do
          [
            Hashie::Mash.new({data:{name:"T1000"}, self:"http://localhost/db/data/node/310"}),
            Hashie::Mash.new({data:{name:"T1011"}, self:"http://localhost/db/data/node/311"})
          ]
        end
        let(:response_body) do
          Hashie::Mash.new({ columns: ["age"], data: results })
        end
      end

      context "and the results are not hashes" do
        let(:response_body) do
          Hashie::Mash.new({ columns: ["age"], data: [25, 50, 75] })
        end
        its(:first) { should be_kind_of(Keymaker::CypherStruct) }
        its(:count) { should == 3 }
      end

    end

    context "when there's more than one column in the results" do
    end

  end

end
