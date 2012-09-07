# Keymaker

A multi-layer REST API Ruby wrapper for the Neo4j graph database built on top of [Faraday][].

```
Oracle: Our time is up. Listen to me, Neo.
        You can save Zion if you reach The Source,
        but to do that you will need the Keymaker.
Neo:    The Keymaker?
```

## Installation

Install and start the Neo4j server:

```ruby
rake neo4j:install
rake neo4j:start
# optionally for testing
rake neo4j:install RAILS_ENV=test
rake neo4j:start RAILS_ENV=test
```

Add this line to your application's Gemfile:

```ruby
gem 'keymaker'
```

And then execute:

```
$ bundle
```

## Usage

### Configuration

Create a `config/neo4j.yml` file:

```ruby
development:
  server: localhost
  port: 7474
test:
  server: localhost
  port: 7475
```

Then, create a Rails initializer `config/initializers/keymaker.rb`:

```ruby
if Rails.env.development? || Rails.env.test?
  database_config = YAML::load_file('config/neo4j.yml')
  Keymaker.configure do |c|
    c.server = database_config["#{Rails.env}"]['server']
    c.port = database_config["#{Rails.env}"]['port']
  end
else
  # Heroku neo4j add-on
  Keymaker.configure do |c|
    c.server = ENV['NEO4J_HOST']
    c.port = ENV['NEO4J_PORT']
    c.username = ENV['NEO4J_LOGIN']
    c.password = ENV['NEO4J_PASSWORD']
  end
end
```

### Low-level REST API Calls

```ruby

Keymaker.configure do |c|
  c.server = "localhost"
  c.port = 7474
end

## Create a node ##

response = Keymaker.service.create_node_request({:name => 'John Connor', :catch_phrase => 'No problemo'})

## Update node properties ##

## Delete a node ##

## Create a relationship ##

## Update relationship properties ##

## Delete a relationship ##

```

### Nodes

```
Coming soon
```

### Relationships

```
Coming soon
```

### Indices

```
Coming soon
```

### Querying

```
Coming soon
```

## Contributing

1. Fork it
2. Create a feature branch (`git checkout -b my_new_feature`)
3. Write passing tests!
3. Commit your changes (`git commit -v`)
4. Push to the branch (`git push origin my_new_feature`)
5. Create new Pull Request

## TODO:

- Test coverage
- Contributing documentation (installing neo4j, etc).
- Documentation

## Acknowledgements

- Avdi Grimm
- Micah Cooper
- Stephen Caudill
- Travis Anderson

## Copyright
Copyright (c) 2012 [Rogelio J. Samour](mailto:rogelio@therubymug.com)
See [LICENSE][] for details.

[license]: https://github.com/therubymug/keymaker/blob/master/LICENSE.md
[faraday]: https://github.com/technoweenie/faraday
