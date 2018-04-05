require 'rspec'
require 'capybara-screenshot/cucumber'
require 'capybara/cucumber'
require 'site_prism'
require 'capybara'
require 'selenium-webdriver'
require 'yaml'
require 'capybara/rspec'
require 'pry'
require 'phantomjs'
require 'capybara/poltergeist'
require 'selenium/webdriver'

$browser = 'browserstack'

# monkey patch to avoid reset sessions
class Capybara::Selenium::Driver < Capybara::Driver::Base
  def reset!
    if @browser
      @browser.navigate.to('about:blank')
    end
  end
end

TASK_ID = (ENV['TASK_ID'] || 0).to_i
CONFIG = YAML.load_file(File.expand_path("../../config/single_config.yml", __FILE__))
CONFIG['user'] = ENV['BROWSERSTACK_USERNAME'] || CONFIG['user']
CONFIG['key'] = ENV['BROWSERSTACK_ACCESS_KEY'] || CONFIG['key']

Capybara.register_driver :browserstack do |app|
  @caps = CONFIG['common_caps'].merge(CONFIG['browser_caps'][TASK_ID])

  # Code to start browserstack local before start of test
  if @caps['browserstack.local'] && @caps['browserstack.local'].to_s == 'true';
    @bs_local = BrowserStack::Local.new
    bs_local_args = {"key" => "#{CONFIG['key']}"}
    @bs_local.start(bs_local_args)
  end

  Capybara::Selenium::Driver.new(app,
    :browser => :remote,
    :url => "http://#{CONFIG['user']}:#{CONFIG['key']}@#{CONFIG['server']}/wd/hub",
    :desired_capabilities => @caps
  )
end

# Code to stop browserstack local after end of test
at_exit do
  @bs_local.stop unless @bs_local.nil? 
end

Capybara.register_driver :selenium_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => { 'args' => ['--start-maximized'] })
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
end

  if 'selenium' == $browser
    ##Rodar com o browser ativo##
    Capybara.default_driver = :selenium_chrome
  elsif 'poltergeist' == $browser
    ##Rodar em modo headless browser##
    Capybara.default_driver    = :poltergeist
    Capybara.javascript_driver = :poltergeist
  elsif 'browserstack' == $browser
    Capybara.default_driver = :browserstack
  end

Capybara.default_max_wait_time = 10
Capybara.current_session.driver.browser.manage.window.resize_to(1200, 800)
 # Variavel de configuração de BASE_URL de ambiente
$ambiente = 'homo' || ENV['AMBIENTE']
 # Arquivo de BASE_URL, Url de ambiente
$base_url = YAML.load_file('./features/config/environment.yml')[$ambiente]
