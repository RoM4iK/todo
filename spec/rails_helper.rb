
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'shoulda'
require 'database_cleaner'
require 'capybara/rspec'
require 'capybara/poltergeist'
require "paperclip/matchers"
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.javascript_driver = :poltergeist

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.include Paperclip::Shoulda::Matchers
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.around(:each) do |example|
    if example.metadata[:js]
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, timeout: 1000, js_errors: false)
      end
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.cleaning do
        example.run
    end
  end

  config.include Paperclip::Shoulda::Matchers
  config.include ControllersHelper, type: :controller
  config.include ControllersExamples, type: :controller
  config.include FeaturesHelper, type: :feature

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :rails
  end
end
