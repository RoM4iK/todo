
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda'
require 'database_cleaner'
require 'capybara/rspec'
require 'capybara/poltergeist'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.javascript_driver = :poltergeist

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.cleaning do
        example.run
    end
  end

  config.include ControllersHelper, type: :controller
  config.include ControllersExamples, type: :controller

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :rails
  end
end
