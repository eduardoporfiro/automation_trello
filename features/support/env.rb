require 'httparty'
require 'capybara'
require 'capybara/cucumber'
require 'dotenv'
require 'selenium-webdriver'
require 'byebug'
require 'colorize'
require 'yaml'
require 'faker'
Dotenv.load('default.env')

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :chrome
  config.javascript_driver = config.default_driver
  config.default_selector = :xpath
  config.default_max_wait_time = 100
end

Capybara.register_driver(:chrome) {|app|
  headless_opts = %w(--headless --window-size=1920,1080 --disable-gpu)
  options =
      %w(--start-maximized --disable-infobars --incognito --disable-popup-blocking --disable-extensions)
  options.concat headless_opts if ENV['HEADLESS'] == 'true'
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions': {'args' => options}
    )
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: caps)
}