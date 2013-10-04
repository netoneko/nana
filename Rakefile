task :environment do
  require File.join(File.dirname(__FILE__), "config/environment")
end

task :generate => :environment do
  Dir.chdir File.join(File.dirname(__FILE__), "nanoc") do
    Nanoc::CLI.run ["compile"]
  end
end

namespace :db do
  task :seed => :environment do
    root = Nana::Page.create!(content: "This is index page", title: "Home")
    about = Nana::Page.create!(title: "About Us", content: "About page", parent: root, slug: "about")
    tech = Nana::Page.create!(title: "Technologies", content: "Tech page", parent: root, slug: "tech")
    ruby = Nana::Page.create!(title: "Ruby", content: "We do Ruby", parent: tech, slug: "ruby")
  end

  task :cleanup => :environment do
    Nana::Page.delete_all
  end

  task :reseed => [:cleanup, :seed]
end

task :console => :environment do
  binding.pry
end
