module TeamCity
  module ServiceMessages

    class << self
      
      def publish_artifacts(path)
        publish_message "##teamcity[publishArtifacts '#{path}']"
      end

      def import_data(type, path)
        publish_message "##teamcity[importData type='#{type}' path='#{path}']"
      end
      
      def publish_message(message)
        puts message if TeamCity.teamcity_build?
      end
    
    end

  end
end