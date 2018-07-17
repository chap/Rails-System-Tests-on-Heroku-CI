require "test_helper"

# tell Heroku CI run where to find chrome binary
# https://github.com/heroku/heroku-buildpack-google-chrome#selenium
chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
chrome_opts = chrome_bin ? Selenium::WebDriver::Chrome::Options.new(binary: chrome_bin) : {}

Capybara.register_driver :chrome_shim do |app|
  Capybara::Selenium::Driver.new(
     app,
     browser: :chrome,
     desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
  )
end

Capybara.javascript_driver = :chrome_shim

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :chrome_shim
end
