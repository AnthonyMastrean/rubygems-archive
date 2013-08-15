require_relative '../lib/slowrcheetah'

task :default do
  puts 'pick a task'
end

apprc :apprc do |app|
  app.files = FileList['**/app.rc']
  app.version = '0.0.5.0'
end

appconfig :appconfig do |app|
  app.files = FileList['**/*.eappe.config']
  app.replacements = {
    "/configuration/applicationSettings/*/setting[@name='FullScreen']/value" => 'True',
    "/configuration/applicationSettings/*/setting[@name='Profile']/value" => 'Simluation', }
end
