require 'nokogiri'

def appconfig(*args, &block)
  config = AppConfig::Configuration.new
  block.call config
  
  body = proc {
    task = AppConfig::Task.new config.files, config.replacements
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module AppConfig
  class Configuration
    attr_accessor :files, :replacements
  end
  
  class Task
    def initialize(files, replacements)
      @files = files
      @replacements = replacements
    end
  
    def execute
      @files.each do |file|
        puts "Transforming #{file}"
        doc = Nokogiri::XML File.open file
        replacements.each do |key, value| 
          #puts "> xpath: #{key}"
          doc.xpath(key).each do |el|
            #puts ">> replacing #{el.content} with #{value}"
            el.content = value
          end
        end
      
        File.open file, 'w' do |f| 
          f.write(doc)
        end
      end
    end
  end
end
