shared_examples_for "ActiveModel" do
  require 'test/unit/assertions'
  require 'active_model/lint'
  include Test::Unit::Assertions
  include ActiveModel::Lint::Tests

  ActiveModel::Lint::Tests.public_instance_methods.map {|m| m.to_s}.grep(/^test/).each do |method|
    example method.gsub("_", " ") do
      send method
    end
  end

  def model
    subject
  end

end
