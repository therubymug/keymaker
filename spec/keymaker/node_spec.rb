require 'spec_helper'

class Terminator
  include Keymaker::Node
  property :name
  index on: :name
end

RSpec.describe Keymaker::Node do

  let(:terminator) { Terminator.create(name: 'T1000') }

  subject { terminator }

  describe ".create" do
    subject { terminator }
    its(:node_id) { should be_present }
    its(:name) { should eq('T1000') }
    it { is_expected.to_not be_new_node }
    it { is_expected.to be_a(Terminator) }
  end

  describe ".find_all_by_cypher(query, params)" do

    subject { Terminator.find_all_by_cypher(query) }
    let(:query) { "START all=node(*) RETURN all" }

    context "with existing nodes" do
      before { terminator }
      it { is_expected.to be_a(Array) }
      its(:first) { is_expected.to_not be_new_node }
      its(:first) { is_expected.to be_a(Terminator) }
    end

    context "without existing nodes" do
      it { is_expected.to be_a(Array) }
      it { is_expected.to be_blank }
    end

  end

  describe ".find(node_id)" do

    subject { Terminator.find(node_id) }

    context "when terminator is present" do
      let(:node_id) { terminator.node_id }

      its(:node_id) { should be_present }
      its(:name) { should eq('T1000') }
      it { is_expected.to be_present }
      it { is_expected.to_not be_new_node }
      it { is_expected.to be_a(Terminator) }
    end

    context "when terminator is not present" do
      let(:node_id) { 9001 }
      it "raises an Keymaker::ResourceNotFound error" do
        expect { subject }.to raise_error(Keymaker::ResourceNotFound)
      end
    end

  end

  describe "#persisted?" do
    let(:new_node) { Terminator.new(name: "T1000") }
    subject { node.persisted? }

    context "when persisted" do
      let(:node) { new_node.save }
      it { expect(subject).to eq(true) }
    end

    context "when not persisted" do
      let(:node) { new_node }
      it { expect(subject).to eq(false) }
    end

  end

  describe "#to_key" do

    context "when persisted" do
      subject(:to_key) { terminator.to_key }
      its(:first) { is_expected.to be_a(Integer)  }
      it { expect(subject).to include(terminator.node_id)  }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_key }
      it { expect(subject).to be_blank  }
    end

  end

  describe "#to_param" do

    context "when persisted" do
      subject { terminator.to_param }
      it { expect(subject).to eq(terminator.node_id.to_s) }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_param }
      it { expect(subject).to be_nil }
    end

  end

end
