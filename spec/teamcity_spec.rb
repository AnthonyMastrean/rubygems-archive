require 'spec_helper'
require 'teamcity_service_messages.rb'

describe TeamCity, 'when publishing artifacts' do
  before(:all) do
    TeamCity::publish_artifacts 'artifact.txt'
  end

  it 'should print the publish artifacts service message' do
  end
end

describe TeamCity, 'when importing data' do
  before(:all) do
    TeamCity::import_data 'nunit', 'results.xml'
  end

  it 'should print the import data service message' do
  end
end