require 'spec_helper'
require "addressable/uri"
require 'keymaker'

describe Keymaker do

  include_context "John and Sarah nodes"

  context "indices" do
    include_context "John and Sarah indexed nodes"

    context "given a bad port number" do

      let(:url) { john_node_url.dup.gsub("7477", "49152") }

      after { service.connection = connection }

      def do_it
        connection.get(url) do |req|
          req.options[:timeout] = 0
          req.options[:open_timeout] = 0
        end
      end

      it "raises an error" do
        expect { do_it }.to raise_error
      end

    end

    context "given an explicit connection" do

      let(:url) { john_node_url }

      before { service.connection = test_connection }
      after { service.connection = connection }

      def do_it
        service.connection.get(url)
      end

      it "uses the connection for requests" do
        faraday_stubs.get(Addressable::URI.parse(url).path) do
          [200, {}, "{}"]
        end
        do_it
        faraday_stubs.verify_stubbed_calls
      end

    end

    describe "#add_node_to_index(index_name, key, value, node_id)" do

      def do_it
        service.add_node_to_index(:users, :email, email, node_id)
      end

      context "given existing values" do

        let(:email) { john_email }
        let(:node_id) { john_node_id }
        let(:index_result) { connection.get(index_query_for_john_url).body[0]["self"] }

        it "adds the node to the index" do
          do_it
          index_result.should == john_node_url
        end

        it "returns a status of 201" do
          do_it.status.should == 201
        end

      end

      context "given an invalid node id" do

        let(:email) { john_email }
        let(:node_id) { -22 }

        it "returns a 500 status" do
          do_it.status.should == 500
        end

      end

    end

    describe "#remove_node_from_index(index_name, key, value, node_id)" do

      def do_it
        service.remove_node_from_index(:users, :email, email, node_id)
      end

      context "given existing values" do

        let(:email) { john_email }
        let(:node_id) { john_node_id }

        it "removes the node from the index" do
          do_it
          connection.get(index_query_for_john_url).body.should be_empty
        end

        it "returns a status of 204" do
          do_it.status.should == 204
        end

        it "keeps the other node indices" do
          do_it
          connection.get(index_query_for_sarah_url).body.should_not be_empty
        end

      end

      context "given unmatched values" do

        let(:email) { "unknown@example.com" }
        let(:node_id) { -22 }

        it "returns a 404 status" do
          do_it.status.should == 404
        end

      end

    end
  end

  describe "#execute_query" do

    def do_it
      service.execute_query("START user=node:users(email={email}) RETURN user", email: john_email)
    end

    context "given existing values" do

      before { service.add_node_to_index(:users, :email, john_email, john_node_id) }
      let(:query_result) { do_it["data"][0][0]["self"] }

      it "performs the cypher query and responds" do
        query_result.should == john_node_url
      end

    end

  end

  context "nodes" do

    include_context "Keymaker connections"

    describe "#create_node" do

      let(:properties) { { first_name: "john", last_name: "connor", email: "john@resistance.net" } }

      def do_it
        new_node_id = service.create_node(properties).neo4j_id
        connection.get("/db/data/node/#{new_node_id}/properties").body
      end

      it "creates a node with properties" do
        do_it.should == {"first_name"=>"john", "email"=>"john@resistance.net", "last_name"=>"connor"}
      end

    end

  end

  context "relationships" do

    include_context "Keymaker connections"

    describe "#create_relationship" do

      def do_it
        service.create_relationship(:loves, john_node_id, sarah_node_id).neo4j_id
        connection.get("/db/data/node/#{john_node_id}/relationships/all/loves").body.first
      end

      it "creates the relationship between the two nodes" do
        do_it["start"].should == john_node_url
        do_it["end"].should == sarah_node_url
      end

    end

  end

end
