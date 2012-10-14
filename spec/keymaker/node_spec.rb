require 'spec_helper'

class Terminator
  include Keymaker::Node
  property :name
end

describe Keymaker::Node do

  let(:terminator) { Terminator.create(name: 'T1000') }

  subject { terminator }

  it_behaves_like "ActiveModel"

  describe ".create" do

    subject { terminator }

    it "creates node" do
      subject.name.should == 'T1000'
    end

    it "saves the node" do
      subject.should_not be_new
    end

    it "returns the node object" do
      subject.should be_a(Terminator)
    end

  end

  describe "#persisted?" do
    let(:new_node) { Terminator.new(name: "T1000") }
    subject { node.persisted? }
    context "when persisted" do
      let(:node) { new_node.save }
      it { subject.should be_true }
    end

    context "when not persisted" do
      let(:node) { new_node }
      it { subject.should be_false }
    end
  end

  describe "#to_key" do

    context "when persisted" do
      subject { terminator.to_key }
      it { subject.first.should be_a(Integer)  }
      it { subject.should include(terminator.node_id)  }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_key }
      it { subject.should be_blank  }
    end

  end

  describe "#to_param" do

    context "when persisted" do
      subject { terminator.to_param }
      it { subject.should == terminator.node_id.to_s }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_param }
      it { subject.should be_nil }
    end

  end

end
