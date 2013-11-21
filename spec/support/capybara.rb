require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'


Capybara.configure do |config|
  config.javascript_driver = :webkit if defined? Capybara::Webkit
  config.match = :one
  config.exact_options = true
  config.ignore_hidden_elements = false
  config.visible_text_only = true

  config.app = Rack::Builder.new do
    config_path = Rails.root.join('config.ru').to_s
    eval File.read(config_path), nil, config_path
  end
end


# require 'selenium-webdriver'
# Selenium::WebDriver::Firefox::Binary.path='/usr/bin/firefox'