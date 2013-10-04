# config.ru (run with rackup)
require File.join(File.dirname(__FILE__), "config/environment")

run Nana::Web
