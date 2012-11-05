require 'spec_helper'

class Terminator
  include Keymaker::Node
  attribute :name, String
  index :terminators, on: :name
end

describe Keymaker::Node do

  let(:terminator) { Terminator.create(name: 'T1000') }

  subject { terminator }

  it_behaves_like "ActiveModel"

  describe ".create" do
    subject { terminator }
    its(:neo4j_id) { should be_present }
    its(:name) { should == 'T1000' }
    it do
      should_not be_new_node
    end
    it { should be_a(Terminator) }
  end

  describe "#save" do

    context "when the node is new" do
      it "creates and persists the new node" do
        foo = Terminator.new(name: 'T800')
        foo.should_receive(:create)
        foo.save
      end
    end

    context "when the node is not new" do
      let(:foo) { Terminator.create(name: 'T801') }
      it "creates and persists the new node" do
        foo = Terminator.create(name: 'T800')
        foo.should_not_receive(:create)
        foo.should_receive(:update_attributes)
        foo.name = "T1000"
        foo.save
      end
    end

  end

  describe "#update_attributes(params)" do

    context "when parameter keys are symbols" do

      context "valid keys/values" do
        before { terminator.update_attributes(name: 'T800') }
        it "updates the instance attributes" do
          terminator.name.should == 'T800'
        end
      end

      context "invalid keys/values" do
        it "raises an error" do
          expect {terminator.update_attributes(faux_name: Time.now)}.to raise_error(Keymaker::UnknownAttributeError, /faux_name$/)
        end
      end

      context "persistance" do
        let(:now_now) { Time.now }
        let(:attrs) { {name: 'T800', updated_at: Time.now} }
        before { Timecop.freeze(now_now) }
        after { Timecop.return }
        it "updates the neo4j node properties" do
          Keymaker.service.should_receive(:update_node_properties).with(terminator.neo4j_id, attrs)
          terminator.update_attributes(name: 'T800')
        end
      end

    end

    context "when parameter keys are not symbols" do
      before { terminator.update_attributes('name' => 'T800') }
      it "updates the instance attributes" do
        terminator.name.should == 'T800'
      end
    end

  end

  context "callbacks" do
    context ":after_create" do
      let!(:terminator) { Terminator.create(name: 'T1000') }
      let(:cypher_for_type) { "START n=node:terminators(node_type='Terminator') RETURN ID(n) AS neo4j_id" }
      let(:cypher_for_name) { "START n=node:terminators(name='T1000') RETURN ID(n) AS neo4j_id" }
      context "indices" do
        it "adds the node type to the 'nodes' index'" do
          require 'ruby-debug'; Debugger.start; Debugger.settings[:autoeval] = 1; Debugger.settings[:autolist] = 1; debugger
          Keymaker.service.execute_cypher(cypher_for_type,{}).first.neo4j_id.should == terminator.neo4j_id
        end
        it "adds any user-defined indices" do
          Keymaker.service.execute_cypher(cypher_for_name,{}).first.neo4j_id.should == terminator.neo4j_id
        end
      end
    end
  end

  describe ".find_all_by_cypher(query, params)" do

    subject { Terminator.find_all_by_cypher(query) }
    let(:query) { "START all=node(*) RETURN all" }

    context "with existing nodes" do
      before { terminator }
      it { should be_a(Array) }
      its(:first) { should_not be_new_node }
      its(:first) { should be_a(Terminator) }
    end

    context "without existing nodes" do
      it { should be_a(Array) }
      it { should be_blank }
    end

  end

  describe ".find(neo4j_id)" do

    subject { Terminator.find(neo4j_id) }

    context "when terminator is present" do
      let(:neo4j_id) { terminator.neo4j_id }

      its(:neo4j_id) { should be_present }
      its(:name) { should == 'T1000' }
      it { should be_present }
      it { should_not be_new_node }
      it { should be_a(Terminator) }
    end

    context "when terminator is not present" do
      let(:neo4j_id) { 9001 }
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
      it { subject.should include(terminator.neo4j_id)  }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_key }
      it { subject.should be_blank  }
    end

  end

  describe "#to_param" do

    context "when persisted" do
      subject { terminator.to_param }
      it { subject.should == terminator.neo4j_id.to_s }
    end

    context "when not persisted" do
      subject { Terminator.new(name: "T1000").to_param }
      it { subject.should be_nil }
    end

  end

end
