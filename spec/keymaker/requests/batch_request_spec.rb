require 'spec_helper'
require 'keymaker'

describe Keymaker::BatchRequest, :vcr => true do

  let(:batch_request) { Keymaker::BatchRequest.new(Keymaker.service, options).submit }

  context "when :to and :method are not set" do
    let(:options) do
      [ { foo: "WET", ot: "/node/1" } ]
    end
    it "raises BatchRequestError" do
      expect { batch_request }.to raise_error(Keymaker::BatchRequestError)
    end
  end

  context "when a resource is not found" do
    let(:options) do
      [ { method: "GET", to: "/node/999999999" } ]
    end
    it "raises BatchRequestError" do
      expect { batch_request }.to raise_error(Keymaker::BatchRequestError)
    end
  end

  context "with valid options" do
    let(:options) do
      [{
        method: "POST",
        to: "/node",
        id: 0,
        body: {
          name: "John Connor"
        }
      }, {
        method: "POST",
        to: "/node",
        id: 1,
        body: {
          name: "Sarah Connor"
        }
      }, {
        method: "POST",
        to: "{0}/relationships",
        id: 2,
        body: {
          to: "{1}",
          data: {
            since: "1985"
          },
          type: "knows"
        }
      }]
    end

    it "returns a 200 status code" do
      batch_request.status.should == 200
    end

  end

end
