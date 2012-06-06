module Keymaker

  class BatchGetNodesRequest < Request

    def submit
      service.post(batch_path, batch_get_nodes_properties)
    end

    def batch_get_nodes_properties
      [].tap do |batch_request|
        opts.each_with_index do |node_id, request_id|
          batch_request << {id: request_id, to: node_uri(node_id), method: "GET"}
        end
      end
    end

  end

end
