lib = File.dirname(File.expand_path(__FILE__))
Dir.glob(File.join(lib, '/teamcity_service_messages/*.rb')).each do |file|
  require File.basename(file, File.extname(file))
end

module TeamCityServiceMessages
  class << self
    def teamcity_build?
      ENV.include?('TEAMCITY_PROJECT_NAME')
    end

    def teamcity_agent?
      Dir.exists?('C:/BuildAgent')
    end

    def publish_artifacts(path)
      publish_message "##teamcity[publishArtifacts '#{path}']"
    end

    def import_data(type, path)
      publish_message "##teamcity[importData type='#{type}' path='#{path}']"
    end
    
    def publish_message(message)
      puts message if teamcity_build?
    end
  end
end