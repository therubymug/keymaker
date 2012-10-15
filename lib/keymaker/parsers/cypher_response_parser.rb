module Keymaker
  class CypherResponseParser

    def self.parse(response_body)
      response_body.data.map do |result|
        if response_body.columns.one? && result.first.kind_of?(Hashie::Mash)
          result.first.data
        else
          translate_response(response_body, result)
        end
      end
    end

    def self.translate_response(response_body, result)
      Hashie::Mash.new(Hash[sanitized_column_names(response_body).zip(result)])
    end

    def self.sanitized_column_names(response_body)
      response_body.columns.map do |column|
        column[/[^\.]+$/]
      end
    end

  end
end
