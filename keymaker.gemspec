# -*- encoding: utf-8 -*-
## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'keymaker'
  s.version           = '0.0.8'
  s.date              = '2012-07-19'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.description   = %q{A multi-layer REST API wrapper for neo4j.}
  s.summary       = %q{A multi-layer REST API wrapper for neo4j.}

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors       = ["Rogelio J. Samour", "Travis L. Anderson"]
  s.email         = ["rogelio@therubymug.com", "travis@travisleeanderson.com"]
  s.homepage      = "https://github.com/therubymug/keymaker"

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  ## s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE.md]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  ## s.add_dependency('DEPNAME', [">= 1.1.0", "< 2.0.0"])
  s.add_dependency 'activemodel'
  s.add_dependency 'activesupport'
  s.add_dependency 'addressable'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  ## s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'ruby-debug19'
  s.add_development_dependency 'vcr'

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
    lib/keymaker/requests/path_traverse_request.rb
    lib/keymaker/requests/remove_node_from_index_request.rb
    lib/keymaker/requests/service_root_request.rb
    lib/keymaker/requests/update_node_properties_request.rb
    lib/keymaker/response.rb
    lib/keymaker/serialization.rb
    lib/keymaker/service.rb
    spec/cassettes/Keymaker_AddNodeToIndexRequest/returns_a_201_status_code.yml
    spec/cassettes/Keymaker_AddNodeToIndexRequest/returns_application/json.yml
    spec/cassettes/Keymaker_AddNodeToIndexRequest/returns_the_Neo4j_REST_API_starting_point_response_request.yml
    spec/cassettes/Keymaker_BatchRequest/when_a_resource_is_not_found/raises_BatchRequestError.yml
    spec/cassettes/Keymaker_BatchRequest/when_to_and_method_are_not_set/raises_BatchRequestError.yml
    spec/cassettes/Keymaker_BatchRequest/with_valid_options/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_BatchRequest/with_valid_options/runs_the_commands_and_returns_their_respective_results.yml
    spec/cassettes/Keymaker_GetNodeRequest/with_a_non-existent_node_id/raises_ResourceNotFound.yml
    spec/cassettes/Keymaker_GetNodeRequest/with_an_empty_node_id/raises_ClientError.yml
    spec/cassettes/Keymaker_GetRelationshipTypesRequest/with_existing_relationships/returns_a_unique_array_of_relationship_types.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_a_200_status_code.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_application/json.yml
    spec/cassettes/Keymaker_ServiceRootRequest/returns_the_Neo4j_REST_API_starting_point_response_request.yml
    spec/configuration_spec.rb
    spec/keymaker/requests/add_node_to_index_request_spec.rb
    spec/keymaker/requests/batch_get_nodes_request_spec.rb
    spec/keymaker/requests/batch_request_spec.rb
    spec/keymaker/requests/delete_node_request_spec.rb
    spec/keymaker/requests/get_node_request_spec.rb
    spec/keymaker/requests/get_relationship_types_request_spec.rb
    spec/keymaker/requests/service_root_request_spec.rb
    spec/keymaker_spec.rb
    spec/service_spec.rb
    spec/spec_helper.rb
    spec/support/keymaker.rb
    spec/support/vcr.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files    = s.files.grep(%r{^spec/})
end
