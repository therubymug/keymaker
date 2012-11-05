module Keymaker

  module ActiveRecordSync

    def self.included(base)
      base.class_eval do
        include Keymaker::ActiveRecordSync::InstanceMethods
      end
      base.after_save :sync_neo4j_attributes
    end

    module InstanceMethods

      def keymaker_class
        "#{self.class.model_name}Node".constantize
      end

      def neo4j_instance
        @neo4j_instance ||= keymaker_class.find(neo4j_id)
      end

      def neo4j_attributes
        {sync_id: id}
      end

      def sync_neo4j_attributes
        if neo4j_id.present?
          neo4j_instance.update_attributes(neo4j_attributes)
        else
          node = keymaker_class.create(neo4j_attributes)
          update_attribute(:neo4j_id, node.neo4j_id)
        end
      end

    end

  end

end
