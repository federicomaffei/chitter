ENV["RACK_ENV"] = 'test'

require './app/server'
require 'capybara/rspec'
require 'database_cleaner'
require 'features/helpers/session'

Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order = 'random'
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end

RSpec.configure do |c|
  c.include SessionHelpers
end