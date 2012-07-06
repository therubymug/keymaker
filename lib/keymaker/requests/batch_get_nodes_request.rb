module Keymaker

  class BatchGetNodesRequest < BatchRequest

    attr_accessor :node_ids

    def initialize(service, node_ids)
      self.config = service.config
      self.node_ids = node_ids
      self.service = service
      self.opts = build_job_descriptions_collection
    end

    def build_job_descriptions_collection
      [].tap do |batch_jobs|
        node_ids.each_with_index do |node_id, job_id|
          batch_jobs << {id: job_id, to: node_uri(node_id), method: "GET"}
        end
      end
    end

  end

end
