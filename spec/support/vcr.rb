require 'vcr'

VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end
