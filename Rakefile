#############################################################################
#
# Helper functions
#
#############################################################################

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
  line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
  line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

def date
  Date.today.to_s
end

def gemspec_file
  "#{name}.gemspec"
end

def gem_file
  "#{name}-#{version}.gem"
end

def replace_header(head, header_name)
  head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

#############################################################################
#
# Standard tasks
#
#############################################################################

require 'rspec'
require 'rspec/core/rake_task'

desc "Run all specs"
task RSpec::Core::RakeTask.new('spec')

task default: "spec"

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/#{name}.rb"
end

#############################################################################
#
# Custom tasks (add your own tasks here)
#
#############################################################################


#############################################################################
#
# Packaging tasks
#
#############################################################################

desc "Create tag v#{version} and build and push #{gem_file} to Rubygems"
task release: :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "git commit --allow-empty -a -m 'Release #{version}'"
  sh "git tag v#{version}"
  sh "git push origin master"
  sh "git push origin v#{version}"
  sh "gem push pkg/#{name}-#{version}.gem"
end

desc "Build #{gem_file} into the pkg directory"
task build: :gemspec do
  sh "mkdir -p pkg"
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg"
end

desc "Generate #{gemspec_file}"
task gemspec: :validate do
  # read spec file and split out manifest section
  spec = File.read(gemspec_file)
  head, manifest, tail = spec.split("  # = MANIFEST =\n")

  # replace name version and date
  replace_header(head, :name)
  replace_header(head, :version)
  replace_header(head, :date)

  # determine file list from git ls-files
  files = `git ls-files`.
    split("\n").
    sort.
    reject { |file| file =~ /^\./ }.
    reject { |file| file =~ /^(rdoc|pkg)/ }.
    map { |file| "    #{file}" }.
    join("\n")

  # piece file back together and write
  manifest = "  s.files = %w[\n#{files}\n  ]\n"
  spec = [head, manifest, tail].join("  # = MANIFEST =\n")
  File.open(gemspec_file, 'w') { |io| io.write(spec) }
  puts "Updated #{gemspec_file}"
end

desc "Validate #{gemspec_file}"
task :validate do
  libfiles = Dir['lib/*'] - ["lib/#{name}.rb", "lib/#{name}"]
  unless libfiles.empty?
    puts "Directory `lib` should only contain a `#{name}.rb` file and `#{name}` dir."
    exit!
  end
  unless Dir['VERSION*'].empty?
    puts "A `VERSION` file at root level violates Gem best practices."
    exit!
  end
end

#############################################################################
#
# Neo4j tasks
#
#############################################################################

KEYMAKER_ROOT = File.expand_path(File.dirname(__FILE__))
KEYMAKER_TMP_DIR = File.expand_path(File.join(KEYMAKER_ROOT, "tmp"))
NEO4J_INSTALL_DIR = ENV['NEO4J_INSTALL_DIR'] || File.expand_path(File.join(KEYMAKER_TMP_DIR, "keymaker_development"))
NEO4J_PORT = ENV['NEO4J_PORT'] || '7477' # Don't clobber standard neo4j ports 7474 or 7475 for development
NEO4J_MIRROR = ENV['NEO4J_MIRROR'] || "http://dist.neo4j.org"

namespace :neo4j do

  desc "Install neo4j on localhost:#{NEO4J_PORT}. e.g. rake neo4j:install[community,1.9-SNAPSHOT]"
  task :install, :edition, :version do |t, args|
    args.with_defaults(edition: "community", version: "2.3.1")

    source_name = "neo4j-#{args[:edition]}-#{args[:version]}"
    tarball = "#{source_name}-unix.tar.gz"

    puts "Installing #{source_name} to localhost:#{NEO4J_PORT}..."

    ssl_url_true = "org.neo4j.server.webserver.https.enabled=true"
    ssl_url_false = ssl_url_true.gsub("true","false")

    %x[mkdir -p #{KEYMAKER_TMP_DIR}; cd #{KEYMAKER_TMP_DIR}]
    FileUtils.rm_rf(NEO4J_INSTALL_DIR) if Dir.exists?(NEO4J_INSTALL_DIR) && File.owned?(NEO4J_INSTALL_DIR)
    %x[wget #{NEO4J_MIRROR}/#{tarball}]
    %x[tar xvzf #{tarball}]

    %x[mv #{source_name} #{NEO4J_INSTALL_DIR}]
    %x[rm #{tarball}]

    %x[sed -i.bak 's/7474/#{NEO4J_PORT}/g' #{NEO4J_INSTALL_DIR}/conf/neo4j.conf]
    %x[sed -i.bak 's/#{ssl_url_true}/#{ssl_url_false}/g' #{NEO4J_INSTALL_DIR}/conf/neo4j.conf]
    %x[sed -i.bak 's/dbms.security.auth_enabled=true/dbms.security.auth_enabled=false/g' #{NEO4J_INSTALL_DIR}/conf/neo4j.conf]

    puts "#{source_name} Installed into the #{NEO4J_INSTALL_DIR} directory."
    puts "Run `bundle exec rake neo4j:start` to start it"
  end

  desc "Start the neo4j server running on localhost:#{NEO4J_PORT}"
  task :start do
    puts "Starting neo4j for keymaker_development..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j start]
  end

  desc "Stop the neo4j server running on localhost:#{NEO4J_PORT}"
  task :stop do
    puts "Stopping neo4j for keymaker_development..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j stop]
  end

  desc "Restart the neo4j server running on localhost:#{NEO4J_PORT}"
  task :restart do
    puts "Restarting neo4j for keymaker_development..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j restart]
  end

  desc "Wipe out and recreate the neo4j server running on localhost:#{NEO4J_PORT}"
  task :reset do
    puts "Resetting neo4j for keymaker_development..."
    # Stop the server
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j stop]
    # Reset the database
    graph_db_path = File.expand_path(File.join(NEO4J_INSTALL_DIR, "data", "graph.db"))
    log_path = File.expand_path(File.join(NEO4J_INSTALL_DIR, "data", "log"))
    FileUtils.rm_rf(graph_db_path)
    FileUtils.mkdir(graph_db_path)
    # Remove log files
    FileUtils.rm_rf(log_path)
    FileUtils.mkdir(log_path)
    # Start the server
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j start]
  end

end
