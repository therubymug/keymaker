module Keymaker
  class AddNodeToIndexRequest < Request

    def submit
      service.post(node_index_path(opts[:index_name]), {key: opts[:key], value: opts[:value], uri: node_uri(opts[:node_id])})
    end

  end
end
