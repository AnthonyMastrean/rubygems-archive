require 'teamcity_service_messages/version'

module TeamCity
  def teamcity_build?
    ENV.include?('TEAMCITY_PROJECT_NAME')
  end

  def teamcity_agent?
      Dir.exists?('C:/BuildAgent')
  end
      
  def publish_artifacts(path)
     puts "##teamcity[publishArtifacts '#{path}']" if teamcity_build?
  end

  def import_data(type, path)
     puts "##teamcity[importData type='#{type}' path='#{path}']" if teamcity_build?
  end
end
