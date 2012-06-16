# Keymaker

## NOTICE OF WORK IN PROGRESS

A multi-layer REST API Ruby wrapper for the neo4j graph database.

```
Oracle: Our time is up. Listen to me, Neo.
        You can save Zion if you reach The Source,
        but to do that you will need the Keymaker.
Neo:    The Keymaker?
```

## Installation

Add this line to your application's Gemfile:

    gem 'keymaker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keymaker

## Usage

### Configuration

First, create a `config/neo4j.yml` file:

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
    c.port = ENV['NEO4J_PORT'].to_i
    c.username = ENV['NEO4J_LOGIN']
    c.password = ENV['NEO4J_PASSWORD']
  end
end
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
