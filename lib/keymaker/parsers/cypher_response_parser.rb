module Keymaker
  class CypherResponseParser

    def self.parse(response_body)
      response_body.data.map do |response|
        result = response.first
        if response_body.columns.one? && result.kind_of?(Hashie::Mash)
          parse_individually(result)
        else
          translate_response(response_body, parse_individually(result))
        end
      end
    end

    def self.translate_response(response_body, results)
      columns = sanitized_column_names(response_body)
      Hashie::Mash.new(Hash[columns.zip(Array.wrap(results))])
    end

    def self.parse_individually(result)
    end

    def self.sanitized_column_names(response_body)
      response_body.columns.map do |column|
        # TODO: make any non-word character an underscore
        column[/[^\.]+$/]
      end
    end

  end
end
