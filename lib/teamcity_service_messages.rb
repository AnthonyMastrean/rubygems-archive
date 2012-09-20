lib = File.dirname(File.expand_path(__FILE__))
Dir.glob("#{lib}/**/*.rb").each do |file|
  require File.basename(file, File.extname(file))
end

module TeamCity
  def TeamCity.teamcity_build?
    ENV.include?('TEAMCITY_PROJECT_NAME')
  end

  def TeamCity.teamcity_agent?
      Dir.exists?('C:/BuildAgent')
  end
      
  def TeamCity.publish_artifacts(path)
     puts "##teamcity[publishArtifacts '#{path}']" if teamcity_build?
  end

  def TeamCity.import_data(type, path)
     puts "##teamcity[importData type='#{type}' path='#{path}']" if teamcity_build?
  end
end
