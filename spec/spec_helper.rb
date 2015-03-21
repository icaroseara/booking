ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require "codeclimate-test-reporter"
require 'devise'
require 'capybara/rspec'

CodeClimate::TestReporter.start

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include SessionHelpers, type: :feature
  config.include Capybara::DSL
end
