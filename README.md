# TeamCityServiceMessages

If [TeamCity][1] doesn't support your testing framework or build runner out of the box, you can still avail yourself of many TeamCity benefits by customizing your build scripts to interact with the TeamCity server. This makes a wide range of features available to any team regardless of their testing frameworks and runners. Some of these features include displaying real-time test results and customized statistics, changing the build status, and publishing artifacts before the build is finished.

## Installation

Add this line to your application's Gemfile:

    gem 'teamcity_service_messages'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install teamcity_service_messages

## Usage
Use this module to print TeamCity service messages to the console from your Rake build (or any other application, really).

    require 'teamcity_service_messages'

The package currently supports the TeamCity service messages `publishArtifacts` and `importData`. None of the expected character escaping is built in. Please escape your own input.
    
    task :publish_artifacts do
      build_artifacts.each { |file| TeamCity::ServiceMessages.publish_artifact file }
    end
    
    task :import_nunit_results do 
      nunit_results.each { |file| TeamCity::ServiceMessages.import_data 'nunit', file }
    end

The messages will only print if the current build is a TeamCity controlled build. This is determined by testing if the environment includes the well known `TEAMCITY_PROJECT_NAME` variable.

    TeamCity.teamcity_build?
    
You can also test if the current build is running on a TeamCity agent, determined by the existance of the expected agent directory, `c:/BuildAgent`. So it's easily fooled ;)

    TeamCity.teamcity_agent?

## Release Notes
v0.0.3
* Supports messages: `importData` and `publishArtifacts`
* New module structure, top level `TeamCity` and the messages are in `ServiceMessage`

 [1]: http://confluence.jetbrains.net/display/TCD7/Build+Script+Interaction+with+TeamCity