require 'faraday'
require 'faraday_middleware'
require 'active_model'

require 'keymaker/request'
require 'keymaker/response'
require 'keymaker/configuration'
require 'keymaker/service'

require 'keymaker/add_node_to_index_request'
require 'keymaker/batch_get_nodes_request'
require 'keymaker/create_node_request'
require 'keymaker/create_relationship_request'
require 'keymaker/delete_relationship_request'
require 'keymaker/execute_cypher_request'
require 'keymaker/execute_gremlin_request'
require 'keymaker/path_traverse_request'
require 'keymaker/remove_node_from_index_request'
require 'keymaker/update_node_properties_request'

require 'keymaker/indexing'
require 'keymaker/serialization'
require 'keymaker/node'

module Keymaker

  VERSION = "0.0.1"

  def self.service
    @service ||= Keymaker::Service.new(Keymaker::Configuration.new)
  end

  def self.configure
    @configuration = Keymaker::Configuration.new
    yield @configuration
    @service = Keymaker::Service.new(@configuration)
  end

  def self.configuration
    @configuration
  end

end
