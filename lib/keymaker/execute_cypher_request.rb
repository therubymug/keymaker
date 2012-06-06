module Keymaker
  class ExecuteCypherRequest < Request

    def submit
      service.post(full_cypher_path, opts).body
    end

  end
end
