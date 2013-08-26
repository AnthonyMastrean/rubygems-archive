require "nokogiri"

def appconfig(*args, &block)
  config = AppConfig::Configuration.new
  config.filename ||= args.first
  block.call config
  
  body = proc {
    task = AppConfig::Task.new config
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module AppConfig
  class Configuration
    attr_accessor :filename, :replacements
  end
  
  class Task
    def initialize(configuration)
      @filename = configuration.filename
      @replacements = configuration.replacements
    end

    def execute
      puts "Transforming #{@filename}"
      
      doc = Nokogiri::XML File.open @filename
      @replacements.each do |key, value| 
        #puts "> xpath: #{key}"
        doc.xpath(key).each do |el|
          #puts ">> replacing #{el.content} with #{value}"
          el.content = value
        end
      end
    
      File.open @filename, "w" do |file| 
        file.write doc
      end
    end
  end
end
