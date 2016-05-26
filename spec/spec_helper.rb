#This code requires all the gems you need for writing your specs, loads the dummy application, and configures RSpec.

#ENV['RAILS_ENV'] ||= 'test'

ENV['RAILS_ENV'] = 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)

require 'rspec/rails' 
#require 'rspec/autorun' #no longer needed
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'factory_girl_rails'
require 'faker'
require 'shoulda/matchers'
require 'database_cleaner'
require 'bcrypt'

abort("The Rails environment is running in production mode!") if Rails.env.production?
abort("The Rails environment is running in development mode!") if Rails.env.development?

# Factory Girl compatbility
#FactoryGirl.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')
#FactoryGirl.find_definitions

Capybara.javascript_driver = :poltergeist

Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
ActionMailer::Base.default_url_options = { :host => 'www.example.com', :protocol => 'http' }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.default_formatter = 'doc'
  config.color = true
  config.include OurnaropaForum::Engine.routes.url_helpers
  
  config.filter_rails_from_backtrace!
  
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end
