require 'rspec/rails'
require 'rspec/autorun'
require 'rr'
require 'database_cleaner'


RSpec.configure do |config|
  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.include Mongoid::Matchers
  config.mock_with :rr
  config.infer_base_class_for_anonymous_controllers = true
  config.order = "random"
end