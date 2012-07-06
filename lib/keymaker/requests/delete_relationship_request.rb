module Keymaker

  # Example request

  # DELETE http://localhost:7474/db/data/relationship/85
  # Accept: application/json
  # Content-Type: application/json

  class DeleteRelationshipRequest < Request

    def submit
      service.delete(relationship_path(opts[:relationship_id]))
    end

  end

end
