require 'forwardable'

module Keymaker

  module Node

    def self.included(base)

      base.class_eval do
        extend ActiveModel::Callbacks
        extend ActiveModel::Naming
        include ActiveModel::MassAssignmentSecurity
        include ActiveModel::Validations
        include ActiveModel::Conversion

        include Keymaker::Indexing
        include Keymaker::Serialization

        extend Keymaker::Node::ClassMethods
        include Keymaker::Node::InstanceMethods

        attr_writer :new_node
        attr_protected :created_at, :updated_at
      end

      base.after_save :update_indices
      base.after_create :add_node_type_index

      base.class_attribute :property_traits
      base.class_attribute :indices_traits

      base.property_traits = {}
      base.indices_traits = {}

      base.property :active_record_id, Integer
      base.property :node_id, Integer
      base.property :created_at, DateTime
      base.property :updated_at, DateTime

    end

    module ClassMethods
      extend Forwardable

      def_delegator :Keymaker, :service, :neo_service

      def properties
        property_traits.keys
      end

      def property(attribute,type=String)
        property_traits[attribute] = type
        attr_accessor attribute
      end

      def create(attributes)
        new(attributes).save
      end

      def find_by_cypher(query, params={})
        find_all_by_cypher(query, params).first
      end

      def find_all_by_cypher(query, params={})
        neo_service.execute_cypher(query, params)
      end

      def find(node_id)
        node = neo_service.get_node(node_id)
        if node.present?
          new(node.slice(*properties)).tap do |neo_node|
            neo_node.node_id = node.neo4j_id
            neo_node.new_node = false
          end
        end
      end

    end

    module InstanceMethods

      def initialize(attrs = {})
        @new_node = true
        process_attrs(attrs) if attrs.present?
      end

      def neo_service
        self.class.neo_service
      end

      def new?
        @new_node
      end

      def sanitize(attrs)
        serializable_hash(except: :node_id).merge(attrs.except('node_id')).reject {|k,v| v.blank?}
      end

      def save
        create_or_update
      end

      def create_or_update
        run_callbacks :save do
          new? ? create : update(attributes)
        end
      end

      def create
        run_callbacks :create do
          neo_service.create_node(sanitize(attributes)).on_success do |response|
            self.node_id = response.neo4j_id
            self.new_node = false
          end
          self
        end
      end

      def update(attrs)
        process_attrs(sanitize(attrs.merge(updated_at: Time.now.utc.to_i)))
        neo_service.update_node_properties(node_id, sanitize(attributes))
      end

      def add_node_type_index
        neo_service.add_node_to_index('nodes', 'node_type', self.class.model_name, node_id)
      end

      def persisted?
        node_id.present?
      end

      def to_key
        persisted? ? [node_id] : nil
      end

    end

  end

end
