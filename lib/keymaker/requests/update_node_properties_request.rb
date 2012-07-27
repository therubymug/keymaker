module Keymaker

  class UpdateNodePropertiesRequest < Request

    def submit
      service.put(node_properties_path(opts[:node_id]), node_properties).on_error do |response|
        case response.status
        when (400..499)
          raise ClientError.new(response, response.body)
        when (500..599)
          raise ServerError.new(response, response.body)
        end
      end
    end

    def node_properties
      opts.except(:node_id)
    end

  end

end
