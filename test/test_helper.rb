ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

# tell Heroku CI run where to find Chrome binary
# chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
# chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}
#
# Capybara.register_driver :chrome_shim_test do |app|
#   Capybara::Selenium::Driver.new(
#      app,
#      browser: :chrome,
#      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
#   )
# end
#
# Capybara.javascript_driver = :chrome_shim_test

driver_name = :new_chrome
browser_name = :chrome
driver_capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    # see
    # https://robots.thoughtbot.com/headless-feature-specs-with-chrome
    # https://developers.google.com/web/updates/2017/04/headless-chrome
    chromeOptions: {
      args: %w(headless disable-gpu no-sandbox),
      # https://github.com/heroku/heroku-buildpack-google-chrome#selenium
      binary:  ENV.fetch('GOOGLE_CHROME_SHIM', nil)
    }.reject { |_, v| v.nil? }
  )

Capybara.register_driver driver_name do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: browser_name,
    desired_capabilities: driver_capabilities
  )
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
