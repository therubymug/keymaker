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
  s.version           = '0.0.7'
  s.date              = '2012-06-15'

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
    lib/keymaker/add_node_to_index_request.rb
    lib/keymaker/batch_get_nodes_request.rb
    lib/keymaker/configuration.rb
    lib/keymaker/create_node_request.rb
    lib/keymaker/create_relationship_request.rb
    lib/keymaker/delete_relationship_request.rb
    lib/keymaker/execute_cypher_request.rb
    lib/keymaker/execute_gremlin_request.rb
    lib/keymaker/indexing.rb
    lib/keymaker/node.rb
    lib/keymaker/path_traverse_request.rb
    lib/keymaker/rails_tasks.rb
    lib/keymaker/railtie.rb
    lib/keymaker/remove_node_from_index_request.rb
    lib/keymaker/request.rb
    lib/keymaker/response.rb
    lib/keymaker/serialization.rb
    lib/keymaker/service.rb
    lib/keymaker/update_node_properties_request.rb
    spec/keymaker/configuration_spec.rb
    spec/keymaker/service_spec.rb
    spec/keymaker_spec.rb
    spec/spec_helper.rb
    spec/support/keymaker.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files    = s.files.grep(%r{^spec/})
end
