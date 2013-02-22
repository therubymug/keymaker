require 'forwardable'

module Keymaker

  module Node

    def self.included(base)

      base.class_eval do
        include Virtus
        extend ActiveModel::Callbacks
        extend ActiveModel::Naming
        include ActiveModel::MassAssignmentSecurity
        include ActiveModel::Validations
        include ActiveModel::Conversion

        include Keymaker::Indexing

        extend Keymaker::Node::ClassMethods
        include Keymaker::Node::InstanceMethods

        attr_accessor :new_node
        attr_protected :created_at, :updated_at
      end

      base.define_model_callbacks :save, :create

      base.after_save :update_indices
      base.after_create :add_node_type_index
      base.class_attribute :indices_traits
      base.indices_traits = {}

      base.attribute :sync_id, Integer
      base.attribute :neo4j_id, Integer
      base.attribute :created_at, DateTime
      base.attribute :updated_at, DateTime

    end

    module ClassMethods

      extend Forwardable

      def_delegator :Keymaker, :service, :neo_service

      def properties
        attribute_set.entries.map(&:name)
      end

      def create(attributes)
        new(attributes).save
      end

      def find_by_cypher(query, params={})
        find_all_by_cypher(query, params).first
      end

      def find_all_by_cypher(query, params={})
        neo_service.execute_cypher(query, params).map{ |node| wrap(node) }
      end

      def find(node_id)
        node = neo_service.get_node(node_id)
        if node.present?
          new(node.slice(*properties)).tap do |neo_node|
            neo_node.neo4j_id = node.neo4j_id
            neo_node.new_node = false
          end
        end
      end

      def wrap(node_attrs)
        new(node_attrs).tap do |node|
          node.new_node = false
        end
      end

    end

    module InstanceMethods

      def initialize(attrs = {})
        self.attributes = attrs if attrs.present?
        self.new_node = true
      end

      def ==(comparison_object)
        comparison_object.instance_of?(self.class) &&
          neo4j_id.present? &&
          comparison_object.neo4j_id == neo4j_id
      end

      def new_node?
        new_node
      end

      def neo_service
        self.class.neo_service
      end

      def save
        create_or_update
      end

      def create_or_update
        run_callbacks :save do
          new_node? ? create : update_attributes(attributes_for_updating)
        end
      end

      def sanitize(attrs)
        set_attributes(attrs.except(:neo4j_id).reject {|k,v| v.blank?})
      end

      def attributes_for_creating
        # TODO: figure out a way to make the timezone configureable
        sanitize(attributes.merge({created_at: Time.now.utc, updated_at: Time.now.utc}))
      end

      def attributes_for_updating
        attributes_for_creating.except(:created_at)
      end

      def create
        run_callbacks :create do
          neo_service.create_node(attributes_for_creating).on_success do |response|
            self.neo4j_id = response.neo4j_id
            self.new_node = false
          end
          self
        end
      end

      def update_attributes(attrs)
        set_attributes(attrs)
        neo_service.update_node_properties(neo4j_id, attributes_for_updating)
      end

      def set_attributes(attrs)
        attrs.each do |key,value|
          if respond_to?("#{key}=")
            public_send("#{key}=", value)
          else
            raise Keymaker::UnknownAttributeError, "Undefined attribute #{key}"
          end
        end
      end

      def add_node_type_index
        neo_service.add_node_to_index('nodes', 'node_type', self.class.model_name, neo4j_id) if persisted?
      end

      def persisted?
        neo4j_id.present?
      end

      def to_key
        persisted? ? [neo4j_id] : nil
      end

    end

  end

end
