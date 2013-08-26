#require "slowcheetr"
require_relative "../lib/slowcheetr"

task :default do
  puts "pick a task"
end

desc "set the apprc version"
apprc :apprc do |app|
  app.filename = "app.rc"
  app.version = "0.0.6.0"
end

desc "set the app settings"
appconfig :appconfig do |app|
  app.filename = "app.exe.config"
  app.replacements = {
    "/configuration/applicationSettings/*/setting[@name=\"FullScreen\"]/value" => "True",
    "/configuration/applicationSettings/*/setting[@name=\"Profile\"]/value" => "Simluation"
  }
end
