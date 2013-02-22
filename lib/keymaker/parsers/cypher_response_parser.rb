module Keymaker
  class CypherResponseParser

    def self.parse(response_body)
      response_body.data.map do |response|
        CypherStruct.new(response_body.columns, response)
      end
    end

  end
end
