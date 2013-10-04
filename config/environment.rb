require "rubygems"
require "bundler"

env = (ENV['RACK_ENV'] || ENV['RAILS_ENV'] || "development").to_sym
Bundler.require :default, env

Mongoid.load! File.join(File.dirname(__FILE__), "../config/mongoid.yml"), env

require File.join(File.dirname(__FILE__), "../lib/nana")


