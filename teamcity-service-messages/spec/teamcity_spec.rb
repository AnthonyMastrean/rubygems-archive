require 'spec_helper'
require 'teamcity_service_messages'

describe TeamCityServiceMessages, 'when publishing from a local build' do
  before do
    @message = ''
    def puts(value)
      @message = value
    end
  
    TeamCityServiceMessages.publish_message 'hey'
  end
  
  it 'should not print to the console' do
    @message.should be_empty
  end
end

describe TeamCityServiceMessages, 'when publishing from a teamcity build' do
  before do
    ENV['TEAMCITY_PROJECT_NAME'] = 'TEST'

    @message = ''
    def puts(value)
      @message = value
    end
  
    TeamCityServiceMessages.publish_message 'hey'
  end
  
  it 'should print to the console' do
    @message.should eq('hey')
  end
end

describe TeamCityServiceMessages, 'when publishing an artifact' do
  before do
    @message = ''
    def TeamCityServiceMessages.publish_message(value)
      @message = value
    end
    
    TeamCityServiceMessages.publish_artifacts 'artifact.txt'
  end
  
  it 'should print the artifact service messasge' do
    @message.should eq("##teamcity[publishArtifacts 'artifact.txt']")
  end
end

describe TeamCityServiceMessages, 'when importing data' do
  before do
    @message = ''
    def TeamCityServiceMessages.publish_message(value)
      @message = value
    end
    
    TeamCityServiceMessages.import_data 'nunit', 'results.xml'
  end

  it 'should print the import data service @message' do
    @message.should eq("##teamcity[importData type='nunit' path='results.xml']")
  end
end