module Keymaker
  module Node

    def self.find(id)
      Keymaker::Finders.base_query(id)
    end

  end

  module Relationship

    def self.find(id)
    end

  end

  class Finders

    def self.base_query(id)
      cypher_query = cypher_engine.query { node(id) }.to_s
      Keymaker.service.execute_cypher(cypher_query)
    end

    private

    def self.cypher_engine
      ::Neo4j::Cypher
    end

  end
end
