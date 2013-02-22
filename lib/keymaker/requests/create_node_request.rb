module Keymaker

  class CreateNodeRequest < Request

    def submit
      service.post(node_path, opts).on_error do |response|
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
