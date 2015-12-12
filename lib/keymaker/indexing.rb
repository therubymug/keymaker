module Keymaker

  module Indexing

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def index_row(index_name)
        indices_traits[index_name] = indices_traits.fetch(index_name, [])
      end

      # index :users, on: :name, with: :sanitized_name
      # data structure:
      # { users: [{ index_key: :name, value: :sanitized_name }], users: [{ index_key: :email, value: :email }, { index_key: :username, value: :username }] }
      def index(index_name,options)
        index_row(index_name.to_s) << { index_key: options[:on].to_s, value: options.fetch(:with, options[:on]) }
      end
    end

    def update_indices
      self.class.indices_traits.each do |index,traits|
        traits.each do |trait|
          neo_service.remove_node_from_index(index, trait[:index_key], send(trait[:value]), node_id)
          neo_service.add_node_to_index(index, trait[:index_key], send(trait[:value]), node_id)
        end
      end
    end

  end

end
