# Rails System Tests on Heroku CI

- https://devcenter.heroku.com/articles/heroku-ci
- https://devcenter.heroku.com/articles/heroku-ci-browser-and-user-acceptance-testing-uat

## Create an `app.json` file

Define your `test` script and include special chrome buildpacks:
```
{
  "environments": {
    "test": {
      "addons": [
        "heroku-postgresql"
      ],
      "scripts": {
        "test": "rails test:system"
      },
      "buildpacks": [
        { "url": "heroku/ruby" },
        { "url": "https://github.com/heroku/heroku-buildpack-google-chrome" },
        { "url": "https://github.com/heroku/heroku-buildpack-chromedriver" }
      ]
    }
  }
}
```

## Update `test/application_system_test_case.rb`

Define new Capybara driver that uses chrome and uses the buildpack's binaries during a Heroku CI run:

```
# tell Heroku CI run where to find chrome binary
chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil)
chrome_opts = chrome_bin ? { "chromeOptions" => { "binary" => chrome_bin } } : {}
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
```
