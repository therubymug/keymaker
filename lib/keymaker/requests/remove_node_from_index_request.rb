module Keymaker
  class RemoveNodeFromIndexRequest < Request
    def submit
      service.delete(node_full_index_path(opts[:index_name], opts[:key], opts[:value], opts[:node_id]))
    end
  end
end
