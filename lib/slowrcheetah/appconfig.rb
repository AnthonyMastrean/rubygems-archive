require 'nokogiri'

def appconfig(*args)
    args ||= []
        
    config = Struct.new(:files, :replacements).new
    yield(config)
    
    body = proc {
        AppConfigTask.new.execute(config.files, config.replacements)
    }
    
    Rake::Task.define_task(*args, &body)
end

class AppConfigTask
    def execute(files, replacements)
        files.each do |file|
            puts "Updating #{file}"
            doc = Nokogiri::XML(File.open(file))
            replacements.each do |key,value| 
                #puts "> xpath: #{key}"
                doc.xpath(key).each do |el|
                    #puts ">> replacing #{el.content} with #{value}"
                    el.content = value
                end
            end
            
            File.open(file, 'w') { |f| f.write(doc) }
        end
    end
end
