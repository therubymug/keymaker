module Keymaker
  class PathTraverseRequest < Request

    # Example request

    # POST http://localhost:7474/db/data/node/9/traverse/path
    # Accept: application/json
    # Content-Type: application/json
    # {"order":"breadth_first","uniqueness":"none","return_filter":{"language":"builtin","name":"all"}}

    def submit
      service.post(path_traverse_node_path(opts[:node_id]), path_traverse_properties)
    end

    def path_traverse_properties
      # :order - breadth_first or depth_first
      # :relationships - all, in, or out
      # :uniqueness - node_global, none, relationship_global, node_path, or relationship_path
      # :prune_evaluator
      # :return_filter
      # :max_depth

      {}.tap do |properties|
        properties[:order] = opts.fetch(:order, "breadth_first")
        properties[:relationships] = opts.fetch(:relationships, "all")
        properties[:uniqueness] = opts.fetch(:uniqueness, "relationship_global")
        properties[:prune_evaluator] = opts[:prune_evaluator] if opts[:prune_evaluator]
        properties[:return_filter] = opts[:return_filter] if opts[:return_filter]
        properties[:max_depth] = opts[:max_depth] if opts[:max_depth]
      end
    end

  end
end
