module Keymaker

  # Example request

  # DELETE http://localhost:7474/db/data/relationship/85
  # Accept: application/json
  # Content-Type: application/json

  class DeleteRelationshipRequest < Request

    def submit
      service.delete(relationship_path(opts[:relationship_id])).on_error do |response|
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
