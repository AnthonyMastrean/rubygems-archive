require_relative 'teamcity_service_messages/version'
require_relative 'teamcity_service_messages/service_messages'

module TeamCity

  class << self

    def teamcity_build?
      ENV.include? 'TEAMCITY_PROJECT_NAME'
    end

    def teamcity_agent?
      Dir.exists? 'C:/BuildAgent'
    end

  end  

end