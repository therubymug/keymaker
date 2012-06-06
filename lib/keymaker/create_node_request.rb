module Keymaker

  class CreateNodeRequest < Request

    def submit
      service.post(node_path, opts)
    end

  end

end
