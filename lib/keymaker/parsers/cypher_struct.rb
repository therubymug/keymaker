require 'ostruct'

module Keymaker

  class CypherStruct < OpenStruct

    def initialize(columns, result)
      super(process(columns, result))
    end

    private

    def process(columns=[], result={})
      case result
      when Hash
        if result.has_key?(:self)
          result.data.merge(neo4j_id: result[:self][/\d+$/].to_i)
        else
          result.data
        end
      when Array
        result.each { |r| process(columns, translate_response(columns, r)) }
      else
      end
    end

    # if response_body.columns.one? && result.kind_of?(Hashie::Mash)
    #   parse_individually(result)
    # else
    #   translate_response(response_body, parse_individually(result))
    # end

    def translate_response(columns, results)
      columns = sanitized_column_names(columns)
      Hashie::Mash.new(Hash[columns.zip(Array.wrap(results))])
    end

    def self.sanitized_column_names(response_body)
      response_body.columns.map do |column|
        # TODO: make any non-word character an underscore
        column[/[^\.]+$/]
      end
    end

  end

end
