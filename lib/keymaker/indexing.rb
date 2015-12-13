module Keymaker

  module Indexing

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def index(options)
        neo_service.execute_cypher("CREATE INDEX ON :#{self.model_name.human}(#{options[:on]})", {})
      end

    end

  end

end
