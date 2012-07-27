module Keymaker

  # Example request

  # POST http://localhost:7474/db/data/node/85/relationships
  # Accept: application/json
  # Content-Type: application/json
  # {"to" : "http://localhost:7474/db/data/node/84", "type" : "LOVES", "data" : {"foo" : "bar"}}

  class CreateRelationshipRequest < Request

    def submit
      service.post(relationships_path_for_node(opts[:node_id]), rel_properties).on_error do |response|
        case response.status
        when (400..499)
          raise ClientError.new(response, response.body)
        when (500..599)
          raise ServerError.new(response, response.body)
        end
      end
    end

    def rel_properties
      {}.tap do |properties|
        properties[:to] = node_uri(opts[:end_node_id])
        properties[:type] = opts[:rel_type]
        properties[:data] = opts[:data] if opts[:data]
      end
    end

  end

end
