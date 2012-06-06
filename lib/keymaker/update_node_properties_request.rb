module Keymaker

  class UpdateNodePropertiesRequest < Request

    def submit
      service.put(node_properties_path(opts[:node_id]), node_properties)
    end

    def node_properties
      opts.except(:node_id)
    end

  end

end
