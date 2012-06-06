require "addressable/uri"

module Keymaker

  class Service

    attr_accessor :config

    def initialize(config)
      self.config = config
    end

    def connection=(connection)
      @connection = connection
    end

    def connection
      @connection ||= Faraday.new(url: config.service_root) do |conn|
        conn.request :json
        conn.use FaradayMiddleware::ParseJson, content_type: /\bjson$/
        conn.adapter :net_http
      end
    end

    # Create Node
    def create_node(attrs)
      create_node_request(attrs)
    end

    def create_node_request(opts)
      CreateNodeRequest.new(self, opts).submit
    end

    # Update Node properties
    def update_node_properties(node_id, attrs)
      update_node_properties_request({node_id: node_id}.merge(attrs))
    end

    def update_node_properties_request(opts)
      UpdateNodePropertiesRequest.new(self, opts).submit
    end

    # Create Relationship
    def create_relationship(rel_type, start_node_id, end_node_id, data={})
      create_relationship_request({node_id: start_node_id, rel_type: rel_type, end_node_id: end_node_id, data: data})
    end

    def create_relationship_request(opts)
      CreateRelationshipRequest.new(self, opts).submit
    end

    # Delete Relationship
    def delete_relationship(relationship_id)
      delete_relationship_request(relationship_id: relationship_id)
    end

    def delete_relationship_request(opts)
      DeleteRelationshipRequest.new(self, opts).submit
    end

    # Add Node to Index
    def add_node_to_index(index_name, key, value, node_id)
      add_node_to_index_request(index_name: index_name, key: key, value: value, node_id: node_id)
    end

    def add_node_to_index_request(opts)
      AddNodeToIndexRequest.new(self, opts).submit
    end

    # Remove Node from Index
    def remove_node_from_index(index_name, key, value, node_id)
      remove_node_from_index_request(index_name: index_name, key: key, value: value, node_id: node_id)
    end

    def remove_node_from_index_request(opts)
      RemoveNodeFromIndexRequest.new(self, opts).submit
    end

    # Path Traverse
    def path_traverse(start_node_id, data={})
      path_traverse_request({node_id: start_node_id}.merge(data))
    end

    def path_traverse_request(opts)
      PathTraverseRequest.new(self, opts).submit
    end

    # Batch
    ## GET Nodes
    def batch_get_nodes(node_ids)
      batch_get_nodes_request(node_ids)
    end

    def batch_get_nodes_request(opts)
      BatchGetNodesRequest.new(self, opts).submit
    end

    # Cypher Query
    def execute_query(query, params)
      execute_cypher_request({query: query, params: params})
    end

    def execute_cypher_request(opts)
      ExecuteCypherRequest.new(self, opts).submit
    end

    # Gremlin Script
    def execute_script(script, params={})
      execute_gremlin_request({script: script, params: params})
    end

    def execute_gremlin_request(opts)
      ExecuteGremlinRequest.new(self, opts).submit
    end

    # HTTP Verbs

    def get(url, body)
      faraday_response = connection.get(parse_url(url), body)
      Keymaker::Response.new(self, faraday_response)
    end

    def delete(url)
      faraday_response = connection.delete(parse_url(url))
      Keymaker::Response.new(self, faraday_response)
    end

    def post(url, body)
      faraday_response = connection.post(parse_url(url), body)
      Keymaker::Response.new(self, faraday_response)
    end

    def put(url, body)
      faraday_response = connection.put(parse_url(url), body)
      Keymaker::Response.new(self, faraday_response)
    end

    def parse_url(url)
      connection.build_url(url).tap do |uri|
        if uri.port != config.port
          raise RuntimeError, "bad port"
        end
      end
    end

  end
end
