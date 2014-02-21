require 'capybara'
require 'yaml'

class Autologin
  def initialize
    unless File.exist?('config.yml')
      puts "Create config.yml with:\n#{{"user" => "your user name", "password" => "your password", "browser" => :internet_explorer}.to_yaml}"
      raise "Missing config.yml"
    end

    @config = YAML.load_file('config.yml')

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => @config["browser"])
    end

    @session = Capybara::Session.new(:selenium)
  end

  def login
    @session.visit("http://account.dyn.com/entrance")
    loginbox = @session.find("#loginbox")
    loginbox.fill_in("username", with: @config["user"])
    loginbox.fill_in("password", with: @config["password"])
    loginbox.click_button("Log in")
  end

  def logout
    @session.find("#topnav").click_link("Log Out")
  end
end

al = Autologin.new
al.login
sleep(1)
al.logout
sleep(1)
