# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'keymaker'
  s.version           = '0.0.9'
  s.date              = '2012-09-22'

  s.description   = %q{A multi-layer REST API wrapper for neo4j.}
  s.summary       = %q{A multi-layer REST API wrapper for neo4j.}

  s.authors       = ["Rogelio J. Samour", "Travis L. Anderson"]
  s.email         = ["rogelio@therubymug.com", "travis@travisleeanderson.com"]
  s.homepage      = "https://github.com/therubymug/keymaker"

  s.require_paths = %w[lib]

  s.extra_rdoc_files = %w[README.md LICENSE.md]

  s.add_dependency 'activemodel'
  s.add_dependency 'activesupport'
  s.add_dependency 'addressable'
  s.add_dependency 'hashie'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'neo4j-cypher'

  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'pry'

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    LICENSE.md
    README.md
    Rakefile
    keymaker.gemspec
    lib/keymaker.rb
    lib/keymaker/configuration.rb
    lib/keymaker/errors.rb
    lib/keymaker/indexing.rb
    lib/keymaker/match_method.rb
    lib/keymaker/node.rb
    lib/keymaker/rails_tasks.rb
    lib/keymaker/railtie.rb
    lib/keymaker/request.rb
    lib/keymaker/requests/add_node_to_index_request.rb
    lib/keymaker/requests/batch_get_nodes_request.rb
    lib/keymaker/requests/batch_request.rb
    lib/keymaker/requests/create_node_request.rb
    lib/keymaker/requests/create_relationship_request.rb
    lib/keymaker/requests/delete_node_request.rb
    lib/keymaker/requests/delete_relationship_request.rb
    lib/keymaker/requests/execute_cypher_request.rb
    lib/keymaker/requests/execute_gremlin_request.rb
    lib/keymaker/requests/get_node_request.rb
    lib/keymaker/requests/get_relationship_types_request.rb
    lib/keymaker/requests/remove_node_from_index_request.rb
    lib/keymaker/requests/service_root_request.rb
    lib/keymaker/requests/traverse_path_request.rb
    lib/keymaker/requests/update_node_properties_request.rb
    lib/keymaker/response.rb
    lib/keymaker/serialization.rb
    lib/keymaker/service.rb
    spec/cassettes/Keymaker_AddNodeToIndexRequest/with_valid_options/returns_a_201_status_code.yml
    spec/cassettes/Keymaker_AddNodeToIndexRequest/with_valid_options/returns_application/json.yml
    spec/cassettes/Keymaker_AddNodeToIndexRequest/with_valid_options/returns_the_Neo4j_REST_API_starting_point_response_request.yml
    spec/cassettes/Keymaker_BatchRequest/when_a_resource_is_not_found/raises_BatchRequestError.yml
    spec/cassettes/Keymaker_BatchRequest/when_to_and_method_are_not_set/raises_BatchRequestError.yml
    spec/cassettes/Keymaker_BatchRequest/with_valid_options/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_BatchRequest/with_valid_options/runs_the_commands_and_returns_their_respective_results.yml
    spec/cassettes/Keymaker_CreateNodeRequest/returns_a_201_status_code.yml
    spec/cassettes/Keymaker_CreateNodeRequest/returns_application/json.yml
    spec/cassettes/Keymaker_CreateNodeRequest/with_properties/creates_a_node_with_the_given_properties.yml
    spec/cassettes/Keymaker_CreateNodeRequest/without_properties/creates_an_empty_node.yml
    spec/cassettes/Keymaker_CreateRelationshipRequest/with_invalid_options/raises_ClientError.yml
    spec/cassettes/Keymaker_CreateRelationshipRequest/with_properties/creates_a_node_with_the_given_properties.yml
    spec/cassettes/Keymaker_CreateRelationshipRequest/with_properties/returns_a_201_status_code.yml
    spec/cassettes/Keymaker_CreateRelationshipRequest/with_properties/returns_application/json.yml
    spec/cassettes/Keymaker_CreateRelationshipRequest/without_properties/creates_an_empty_relationship_of_type_birthed_.yml
    spec/cassettes/Keymaker_DeleteRelationshipRequest/with_a_non-existent_relationship/raises_ResourceNotFound.yml
    spec/cassettes/Keymaker_DeleteRelationshipRequest/with_an_existing_relationship/deletes_the_relationship.yml
    spec/cassettes/Keymaker_ExecuteCypherRequest/with_a_valid_Cypher_Query/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_ExecuteCypherRequest/with_an_invalid_Cypher_Query/raises_ClientError.yml
    spec/cassettes/Keymaker_ExecuteGremlinRequest/with_a_valid_Gremlin_Script/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_ExecuteGremlinRequest/with_an_invalid_Gremlin_Script/raises_ClientError.yml
    spec/cassettes/Keymaker_GetNodeRequest/with_a_non-existent_node_id/raises_ResourceNotFound.yml
    spec/cassettes/Keymaker_GetNodeRequest/with_an_empty_node_id/raises_ClientError.yml
    spec/cassettes/Keymaker_GetRelationshipTypesRequest/with_existing_relationships/returns_a_unique_array_of_relationship_types.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_application/json.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_the_Neo4j_REST_API_starting_point_response_request.yml
    spec/cassettes/Keymaker_TraversePathRequest/_traverse_path_properties/with_options/builds_the_query_properties_with_defaults.yml
    spec/cassettes/Keymaker_TraversePathRequest/with_invalid_options/raise_a_ClientError.yml
    spec/cassettes/Keymaker_TraversePathRequest/with_valid_options/returns_status_code_200.yml
    spec/cassettes/Keymaker_UpdateNodePropertiesRequest/_node_properties/excludes_the_node_id.yml
    spec/cassettes/Keymaker_UpdateNodePropertiesRequest/with_invalid_options/raises_a_ClientError.yml
    spec/cassettes/Keymaker_UpdateNodePropertiesRequest/with_valid_options/returns_a_status_of_204.yml
    spec/cassettes/Keymaker_UpdateNodePropertiesRequest/with_valid_options/updates_the_properties.yml
    spec/configuration_spec.rb
    spec/keymaker/requests/add_node_to_index_request_spec.rb
    spec/keymaker/requests/batch_get_nodes_request_spec.rb
    spec/keymaker/requests/batch_request_spec.rb
    spec/keymaker/requests/create_node_request_spec.rb
    spec/keymaker/requests/create_relationship_request_spec.rb
    spec/keymaker/requests/delete_node_request_spec.rb
    spec/keymaker/requests/delete_relationship_request_spec.rb
    spec/keymaker/requests/execute_cypher_request_spec.rb
    spec/keymaker/requests/execute_gremlin_request_spec.rb
    spec/keymaker/requests/get_node_request_spec.rb
    spec/keymaker/requests/get_relationship_types_request_spec.rb
    spec/keymaker/requests/service_root_request_spec.rb
    spec/keymaker/requests/traverse_path_request_spec.rb
    spec/keymaker/requests/update_node_properties_request_spec.rb
    spec/keymaker/service_spec.rb
    spec/keymaker_spec.rb
    spec/service_spec.rb
    spec/spec_helper.rb
    spec/support/keymaker.rb
    spec/support/vcr.rb
  ]
  # = MANIFEST =

  s.test_files    = s.files.grep(%r{^spec/})
end
