require 'capybara'
require 'yaml'

class Autologin
  def initialize
    unless File.exist?('config.yml')
      puts "Create config.yml with:\n#{{"user" => "your user name", "password" => "your password"}.to_yaml}"
      raise "Missing config.yml"
    end

    @config = YAML.load_file('config.yml')
    @config[:browser] = :firefox unless @config[:browser]

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => @config[:browser])
    end

    @session = Capybara::Session.new(:selenium)
  end

  def fill_in loginbox, name, with
    with.length.times do |len|
      loginbox.fill_in(name, with: with[0..len])
      sleep(Random.rand(0.3..1))
    end
  end

  def login
    @session.visit("http://account.dyn.com/entrance")
    loginbox = @session.find("#loginbox")
    fill_in(loginbox, "username", @config[:user])
    fill_in(loginbox, "password", @config[:password])
    sleep(Random.rand(0.3..1))
    loginbox.click_button("Log in")
  end

  def logout
    @session.find("#topnav").click_link("Log Out")
  end
end

al = Autologin.new
al.login
sleep(Random.rand(0.3..1))
al.logout
sleep(Random.rand(0.3..1))
