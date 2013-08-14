require 'rake'
require '../lib/fileupdatetasks'

task :default do
    puts 'pick a task'
end

apprc :apprc do |x|
    x.files = FileList['./**/app.rc']
    x.version = '0.0.5.0'
end

appconfig :appconfig do |x|
    x.files = FileList['./**/*.exe.config']
    x.replacements = {
        "/configuration/applicationSettings/*/setting[@name='FullScreen']/value" => 'True',
        "/configuration/applicationSettings/*/setting[@name='Profile']/value" => 'Simluation', }
end