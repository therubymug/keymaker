require 'spec_helper'

describe Keymaker::CypherResponseParser do

  describe ".parse(response_body)" do
    context "when there's only one column in the results" do
      context "and the results are hashes" do
        it "returns an array of hashes" do
        end
      end
      context "and the results are not hashes" do
      end
    end
    context "when there's more than one column in the results" do
    end
  end
end
