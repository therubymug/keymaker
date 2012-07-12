module Keymaker
  class GetNodeRequest < Request
    def submit
      service.get(node_uri(opts[:node_id]), {}).on_error do |response|
        case response.status
        when 404
          raise ResourceNotFound.new(response, response.body)
        when (400..499)
          raise ClientError.new(response, response.body)
        when (500..599)
          raise ServerError.new(response, response.body)
        end
      end
    end
  end
end
