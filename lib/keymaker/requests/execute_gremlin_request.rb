module Keymaker
  class ExecuteGremlinRequest < Request

    def submit
      service.post(full_gremlin_path, opts).body
    end

  end
end
