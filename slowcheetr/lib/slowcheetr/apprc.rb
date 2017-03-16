def apprc(*args, &block)
  config = AppResource::Configuration.new
  config.filename ||= args.first
  block.call config
  
  body = proc {
    task = AppResource::Task.new config
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module AppResource
  ENCODING      = "UTF-16LE"
  COMMA_PATTERN = /(\d+\,\d+\,\d+\,\d+)/
  DOT_PATTERN   = /(\d+\.\d+\.\d+\.\d+)/
    
  class Configuration
    attr_accessor :filename, :version
  end
  
  class Task  
    @@rx_opt = { mode: "rb", encoding: ENCODING }
    @@wx_opt = { mode: "wb", encoding: ENCODING }

    def initialize(configuration)
      @filename = configuration.filename
      
      @version = configuration.version
      @comma_version = @version.gsub(".", ",").encode ENCODING
      @dot_version = @version.encode ENCODING
      
      @comma_pattern = COMMA_PATTERN.encode ENCODING
      @dot_pattern = DOT_PATTERN.encode ENCODING
    end
    
    def execute
      puts "Updating #{@filename} to v#{@version}"
      
      text = File.read @filename, @@rx_opt
      text.gsub! @comma_pattern, @comma_version
      text.gsub! @dot_pattern, @dot_version
      
      File.open @filename, @@wx_opt do |file|
        file.write text
      end
    end
  end
end
