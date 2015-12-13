require "addressable/uri"

module Keymaker
  class Configuration

    attr_accessor :protocol, :server, :port, :data_directory,
      :authentication, :username, :password

    def initialize(attrs={})
      self.protocol       = attrs.fetch(:protocol) {'http'}
      self.server         = attrs.fetch(:server) {'localhost'}
      self.port           = attrs.fetch(:port) {7474}
      self.authentication = attrs.fetch(:authentication) {{}}
      self.username       = attrs.fetch(:username) {nil}
      self.password       = attrs.fetch(:password) {nil}
      self.data_directory = 'db/data'
    end

    def service_root
      @service_root ||= Keymaker.service.service_root_request.body
    end

    def service_root_url
      Addressable::URI.new(url_opts)
    end

    def url_opts
      {}.tap do |url_opts|
        url_opts[:scheme] = protocol
        url_opts[:host] = server
        url_opts[:port] = port
      end
    end

    def connection_service_root_url
      Addressable::URI.new(connection_url_opts)
    end

    def connection_url_opts
      url_opts.tap do |url_opts|
        url_opts[:user] = username if username
        url_opts[:password] = password if password
      end
    end

    # paths

    def full_cypher_path
      service_root.cypher
    end

    def full_gremlin_path
      service_root.extensions.fetch('GremlinPlugin', {}).fetch('execute_script', nil)
    end

    def node_path
      service_root.node
    end

    def node_properties_path(node_id)
      [node_path, node_id.to_s, 'properties'].join('/')
    end

    def node_uri(node_id)
      [node_path, node_id.to_s].join("/")
    end

    def batch_path
      service_root.batch
    end

    def relationship_path(relationship_id)
      [data_directory, "relationship", relationship_id.to_s].join("/")
    end

    def relationship_types_path
      service_root.relationship_types
    end

    def relationships_path_for_node(node_id)
      [node_path, node_id.to_s, "relationships"].join("/")
    end

    def labels_path_for_node(node_id)
      [node_path, node_id.to_s, "labels"].join("/")
    end

    def node_full_index_path(index_name, key, value, node_id)
      [node_index_path(index_name), key, value, node_id].join("/")
    end

    def node_index_path(index_name)
      [service_root.node_index, index_name.to_s].join("/")
    end

  end
end
