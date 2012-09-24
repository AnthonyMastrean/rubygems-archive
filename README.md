# TeamCityServiceMessages

If [TeamCity](http://confluence.jetbrains.net/display/TCD7/Build+Script+Interaction+with+TeamCity) doesn't support your testing framework or build runner out of the box, you can still avail yourself of many TeamCity benefits by customizing your build scripts to interact with the TeamCity server. This makes a wide range of features available to any team regardless of their testing frameworks and runners. Some of these features include displaying real-time test results and customized statistics, changing the build status, and publishing artifacts before the build is finished.

## Installation

Add this line to your application's Gemfile:

    gem 'teamcity_service_messages'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teamcity_service_messages

## Usage
The intended use is in a Rake build. The messages will only print if the current build is a TeamCity controlled build. This is determined by testing if the environment includes the well known `TEAMCITY_PROJECT_NAME` variable.

    require 'teamcity_service_messages'
    
    task :publish_artifacts do
      build_artifacts.each { |file| TeamCityServiceMessages.publish_artifact file }
    end
    
    task :import_nunit_results do 
      nunit_results.each { |file| TeamCityServiceMessages.import_data 'nunit', file }
    end
