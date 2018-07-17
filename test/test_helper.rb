ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# tell Heroku CI run where to find Chrome binary
chrome_bin = ENV.fetch('GOOGLE_CHROME_BIN', nil)
chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}

Capybara.register_driver :chrome_shim do |app|
  Capybara::Selenium::Driver.new(
     app,
     browser: :chrome,
     desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
  )
end

Capybara.javascript_driver = :chrome_shim

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
