# Inspired by the neo4j tasks in maxdemarzi/neography
NEO4J_INSTALL_DIR = ENV['NEO4J_INSTALL_DIR'] || File.expand_path(File.join(Rails.root, "tmp", "neo_#{Rails.env}"))
NEO4J_PORT = ENV['NEO4J_PORT'] || Rails.env.test? ? "7475" : "7474"

namespace :neo4j do

  desc "Install Neo4j for the current environment. e.g. rake neo4j:install or rake neo4j:install RAILS_ENV=test"
  task :install, [:edition, :version] => [:environment] do |t, args|
    args.with_defaults(:edition => "community", :version => "1.7")
    source_name = "neo4j-#{args[:edition]}-#{args[:version]}"
    tarball = "#{source_name}-unix.tar.gz"

    puts "Installing #{source_name} for #{Rails.env} to localhost:#{NEO4J_PORT}..."

    ssl_url_true = "org.neo4j.server.webserver.https.enabled=true"
    ssl_url_false = ssl_url_true.gsub("true","false")

    FileUtils.rm_rf(NEO4J_INSTALL_DIR) if Dir.exists?(NEO4J_INSTALL_DIR) && File.owned?(NEO4J_INSTALL_DIR)
    %x[wget http://dist.neo4j.org/#{tarball}]
    %x[tar xvzf #{tarball}]

    %x[mv #{source_name} #{NEO4J_INSTALL_DIR}]
    %x[rm #{tarball}]

    %x[sed -i.bak 's/7474/#{NEO4J_PORT}/g' #{NEO4J_INSTALL_DIR}/conf/neo4j-server.properties]
    %x[sed -i.bak 's/#{ssl_url_true}/#{ssl_url_false}/g' #{NEO4J_INSTALL_DIR}/conf/neo4j-server.properties]

    puts "Installed #{source_name} for #{Rails.env} to localhost:#{NEO4J_PORT}..."
    puts "Run `#{"RAILS_ENV=#{Rails.env} " if Rails.env.test?}rake neo4j:start` to start it"
  end

  desc "Start the Neo4j Server"
  task :start => :environment do
    puts "Starting Neo4j for #{Rails.env} on localhost:#{NEO4J_PORT}..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j start]
  end

  desc "Stop the Neo4j Server"
  task :stop => :environment do
    puts "Stopping Neo4j for #{Rails.env} on localhost:#{NEO4J_PORT}..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j stop]
  end

  desc "Restart the Neo4j Server"
  task :restart => :environment do
    puts "Restarting Neo4j for #{Rails.env} on localhost:#{NEO4J_PORT}..."
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j restart]
  end

  desc "Reset the Neo4j Server"
  task :reset => :environment do
    puts "Resetting Neo4j for #{Rails.env} on localhost:#{NEO4J_PORT}..."
    # Stop the server
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j stop]

    # Reset the database
    FileUtils.rm_rf("#{NEO4J_INSTALL_DIR}/data/graph.db")
    FileUtils.mkdir("#{NEO4J_INSTALL_DIR}/data/graph.db")

    # Remove log files
    FileUtils.rm_rf("#{NEO4J_INSTALL_DIR}/data/log")
    FileUtils.mkdir("#{NEO4J_INSTALL_DIR}/data/log")

    # Start the server
    %x[#{NEO4J_INSTALL_DIR}/bin/neo4j start]
  end

end
