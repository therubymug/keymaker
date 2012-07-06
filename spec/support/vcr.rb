require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :fakeweb
  c.allow_http_connections_when_no_cassette = true
end
