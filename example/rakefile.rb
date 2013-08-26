#require "slowcheetr"
require_relative "../lib/slowcheetr"

task :default do
  puts "pick a task"
end

desc "test the apprc task"
apprc :apprc do |app|
  app.files = FileList["**/app.rc"]
  app.version = "0.0.5.0"
end

desc "test the appconfig task"
appconfig :appconfig do |app|
  app.files = FileList["**/*.eappe.config"]
  app.replacements = {
    "/configuration/applicationSettings/*/setting[@name=\"FullScreen\"]/value" => "True",
    "/configuration/applicationSettings/*/setting[@name=\"Profile\"]/value" => "Simluation", }
end
