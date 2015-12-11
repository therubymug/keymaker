ROOT = File.expand_path('../..', __FILE__)
Dir[File.join(ROOT, 'spec/support/**/*.rb')].each {|f| require f}
$LOAD_PATH.unshift(File.expand_path('lib', ROOT))

require 'rspec/its'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
