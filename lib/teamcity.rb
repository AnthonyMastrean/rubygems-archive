require_relative 'teamcity/service_messages'

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