require "addressable/uri"

module Keymaker
  class Configuration

    attr_accessor :protocol, :server, :port,
      :data_directory, :cypher_path, :gremlin_path,
      :log_file, :log_enabled, :logger,
      :authentication, :username, :password

    def initialize(attrs={})
      self.protocol       = attrs.fetch(:protocol) {'http'}
      self.server         = attrs.fetch(:server) {'localhost'}
      self.port           = attrs.fetch(:port) {7474}
      self.data_directory = attrs.fetch(:data_directory) {'db/data'}
      self.cypher_path    = attrs.fetch(:cypher_path) {'cypher'}
      self.gremlin_path   = attrs.fetch(:gremlin_path) {'ext/GremlinPlugin/graphdb/execute_script'}
      self.authentication = attrs.fetch(:authentication) {{}}
      self.username       = attrs.fetch(:username) {nil}
      self.password       = attrs.fetch(:password) {nil}
    end

    def service_root
      service_root_url.to_s
    end

    def service_root_url
      Addressable::URI.new(url_opts)
    end

    def url_opts
      {}.tap do |url_opts|
        url_opts[:scheme] = protocol
        url_opts[:host] = server
        url_opts[:port] = port
        url_opts[:user] = username if username
        url_opts[:password] = password if password
      end
    end

    def full_cypher_path
      [service_root, data_directory, cypher_path].join("/")
    end

    def full_gremlin_path
      [service_root, data_directory, gremlin_path].join("/")
    end

    def node_path
      [data_directory, "node"].join("/")
    end

    def node_properties_path(node_id)
      [node_path, node_id.to_s, "properties"].join("/")
    end

    def path_traverse_node_path(node_id)
      [node_path, node_id.to_s, "traverse", "path"].join("/")
    end

    def batch_node_path(node_id)
      ["/node", node_id.to_s].join("/")
    end

    def batch_path
      [data_directory, "batch"].join("/")
    end

    def relationship_path(relationship_id)
      [data_directory, "relationship", relationship_id.to_s].join("/")
    end

    def relationships_path_for_node(node_id)
      [node_path, node_id.to_s, "relationships"].join("/")
    end

    def node_full_index_path(index_name, key, value, node_id)
      [node_index_path(index_name), key, value, node_id].join("/")
    end

    def node_index_path(index_name)
      [data_directory, "index", "node", index_name.to_s].join("/")
    end

    def node_uri(node_id)
      [service_root, node_path, node_id.to_s].join("/")
    end

  end
end
