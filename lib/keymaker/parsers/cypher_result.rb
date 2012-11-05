require 'ostruct'

module Keymaker

  class CypherResult < OpenStruct

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
      end
    end

  end

end
