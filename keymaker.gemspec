# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'keymaker'
  s.version           = '0.1.0'
  s.date              = '2012-10-14'

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
  s.add_dependency 'virtus'

  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'timecop'
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
    lib/keymaker/parsers/cypher_response_parser.rb
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
    spec/configuration_spec.rb
    spec/keymaker/node_spec.rb
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
    spec/support/active_model_lint.rb
    spec/support/keymaker.rb
    spec/support/vcr.rb
  ]
  # = MANIFEST =

  s.test_files    = s.files.grep(%r{^spec/})
end
