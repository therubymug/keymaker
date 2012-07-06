module Keymaker
  class Request

    extend Forwardable

    def_delegator :config, :batch_node_path
    def_delegator :config, :batch_path
    def_delegator :config, :data_directory_path
    def_delegator :config, :full_cypher_path
    def_delegator :config, :full_gremlin_path
    def_delegator :config, :node_full_index_path
    def_delegator :config, :node_index_path
    def_delegator :config, :node_path
    def_delegator :config, :node_properties_path
    def_delegator :config, :node_uri
    def_delegator :config, :path_traverse_node_path
    def_delegator :config, :relationship_path
    def_delegator :config, :relationships_path_for_node

    def_delegator :response, :body
    def_delegator :response, :status
    def_delegator :response, :faraday_response
    def_delegator :response, :faraday_response=

    attr_accessor :service, :config, :opts

    def initialize(service, options)
      self.config = service.config
      self.opts = options
      self.service = service
    end

  end
end
