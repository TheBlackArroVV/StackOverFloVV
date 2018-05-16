require 'rails_helper'

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  Capybara.server = :puma

  config.include AuthenticationMacros, type: :feature
  config.include QuestionMacros, type: :feature

  config.use_transactional_fixtures = false

  config.before(:suite)              { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each)               { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true)     { DatabaseCleaner.strategy = :truncation }
  config.before(:each, sphinx: true) { DatabaseCleaner.strategy = :deletion }
  config.before(:each)               { DatabaseCleaner.start }
  config.after(:each)                { DatabaseCleaner.clean }
end
