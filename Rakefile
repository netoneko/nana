task :environment do
  require File.join(File.dirname(__FILE__), "config/environment")
end

task :generate => :environment do
  Dir.chdir File.join(File.dirname(__FILE__), "nanoc") do
    Nanoc::CLI.run ["compile"]
  end
end
