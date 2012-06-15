require 'keymaker'

Keymaker.configure do |c|
  c.server = "localhost"
  c.port = 7477
end

shared_context "Keymaker connections" do
  let(:connection) do
    Faraday.new({url: "http://localhost:7477"}) do |conn|
      conn.request :json
      conn.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
      conn.adapter :net_http
    end
  end
  let(:faraday_stubs) do
    Faraday::Adapter::Test::Stubs.new
  end
  let(:test_connection) do
    Faraday.new do |conn|
      conn.adapter :test, faraday_stubs
    end
  end
  let(:service) { Keymaker.service }
end

shared_context "John and Sarah nodes" do
  include_context "Keymaker connections"

  let!(:john_node_url) do
    connection.post("/db/data/node") do |request|
      request.body = {email: john_email}
    end.body["self"]
  end

  let!(:sarah_node_url) do
    connection.post("/db/data/node") do |request|
      request.body = {email: sarah_email}
    end.body["self"]
  end

  let(:john_node_id) { john_node_url.split("/").last }
  let(:sarah_node_id) { sarah_node_url.split("/").last }

  let(:index_query_for_john_url) { "/db/data/index/node/users/email/#{john_email}" }
  let(:index_query_for_sarah_url) { "/db/data/index/node/users/email/#{sarah_email}" }
  let(:delete_index_path_for_john_url) { "/db/data/index/node/users/#{john_node_id}" }

  let(:john_email) { "john@resistance.net" }
  let(:sarah_email) { "sarah@resistance.net" }
end

shared_context "John and Sarah indexed nodes" do

  include_context "John and Sarah nodes"

  let!(:indexed_john) do
    connection.post("db/data/index/node/users") do |request|
      request.body = {
        key: "email",
        value: john_email,
        uri: john_node_url
      }
    end.body
  end

  let!(:indexed_sarah) do
    connection.post("db/data/index/node/users") do |request|
      request.body = {
        key: "email",
        value: sarah_email,
        uri: sarah_node_url
      }
    end.body
  end

end

def clear_graph
  raw_connection.post("/db/data/ext/GremlinPlugin/graphdb/execute_script", {script: "g.clear()\;g.V()"})
end

def clear_users_index
  raw_connection.delete("http://localhost:7477/db/data/index/node/users")
end

def raw_connection
  Faraday.new({url: "http://localhost:7477"}) do |conn|
    conn.request :json
    conn.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
    conn.adapter :net_http
  end
end

RSpec.configure do |config|
  config.before(:all) do
    clear_graph
  end
  config.before(:each) do
    clear_graph
    clear_users_index
  end
  config.after(:all) do
    clear_graph
  end
end
