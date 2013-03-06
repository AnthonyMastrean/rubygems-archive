require '../lib/teamcity'

task :default => [ :publish ]

task :publish do 
  TeamCity::ServiceMessages.publish_artifacts 'fake/file/dot.txt'
end
