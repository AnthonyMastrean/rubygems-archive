def apprc(*args, &block)
  config = AppResource::Configuration.new
  block.call config
  
  body = proc {
    task = AppResource::Task.new config.files, config.version
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module AppResource
  # Known encoding/patterns in the VC++ app.rc
  ENCODING      = 'UTF-16LE'
  COMMA_PATTERN = /(\d+\,\d+\,\d+\,\d+)/
  DOT_PATTERN   = /(\d+\.\d+\.\d+\.\d+)/

  class Configuration
    attr_accessor :files, :version
  end
  
  class Task  
    # Required options for read/write on Windows
    @rx_opt = { mode: 'rb', encoding: ENCODING }
    @wx_opt = { mode: 'wb', encoding: ENCODING }
  
    def initialize(files, version)
      @files = files
      @version = version
      
      @comma_version = version.gsub('.', ',').encode ENCODING
      @dot_version = version.encode ENCODING
        
      @comma_pattern = COMMA_PATTERN.encode ENCODING
      @dot_pattern = DOT_PATTERN.encode ENCODING
    end
    
    def execute
      @files.each do |file|
        puts "Updating #{file} to v#{@version}"
        content = File.read file, @rx_opt
        content.gsub! @comma_pattern, @comma_version
        content.gsub! @dot_pattern, @dot_version
            
        File.open file, @wx_opt do |f| 
          f.write(content)
        end
      end
    end
  end
end
