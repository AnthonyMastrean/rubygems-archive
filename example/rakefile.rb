require "tunny"

task :default => [:attrib, :devenv, :robocopy, :sqlcmd]

attrib :attrib do |cmd|
  cmd.filename = "CommonAssemblyInfo.cs"
  cmd.clear [:readonly]
end

devenv :devenv do |cmd|
  cmd.solution = "example.sln"
  cmd.target = :Build
  cmd.configuration = :Debug
  cmd.platform = "Any CPU"
end

robocopy :robocopy do |cmd|
  cmd.source = "example/bin/Debug"
  cmd.destination = "bin"
  cmd.mirror
end

sqlcmd :sqlcmd do |cmd|
  cmd.server = "LOCALHOST"
  cmd.trusted_connection
  cmd.input_file = "example.sql"
end
