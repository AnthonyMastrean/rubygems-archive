require 'spec_helper'
require 'teamcity_service_messages.rb'

describe TeamCityServiceMessages do
  before do
    ENV['TEAMCITY_PROJECT_NAME'] = 'TEST'
  end
  
  describe 'when publishing artifacts'  do
    before do
      TeamCityServiceMessages.publish_artifacts 'artifact.txt'
    end

    it 'should print the publish artifacts service message' do
    end
  end

  describe 'when importing data' do
    before do
      TeamCityServiceMessages.import_data 'nunit', 'results.xml'
    end

    it 'should print the import data service message' do
    end
  end
end