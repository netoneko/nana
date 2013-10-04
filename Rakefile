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
    root = Nana::Page.create(content: "This is index page")
    about = Nana::Page.create(content: "About Us", parent: root, slug: "about")
    tech = Nana::Page.create(content: "Technologies", parent: root, slug: "tech")
    ruby = Nana::Page.create(content: "Ruby", parent: tech, slug: "ruby")
  end
end
