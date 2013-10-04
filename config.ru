# config.ru (run with rackup)
require File.join(File.dirname(__FILE__), "config/environment")
require File.join(File.dirname(__FILE__), "app/web")

run Nana::Web
