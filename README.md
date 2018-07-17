# Rails System Tests on Heroku CI

- https://devcenter.heroku.com/articles/heroku-ci
- https://devcenter.heroku.com/articles/heroku-ci-browser-and-user-acceptance-testing-uat

## Create an `app.json` file
- you'll need the special chrome buildpacks:
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
define new Capybara driver that uses chrome and uses the buildpack's binaries during a Heroku CI run
