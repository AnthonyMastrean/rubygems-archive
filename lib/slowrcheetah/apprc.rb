def apprc(*args)
    args || args = []
        
    config = Struct.new(:files, :version).new
    yield(config)
    
    body = proc {
        AppResourceTask.new.execute(config.files, config.version)
    }
    
    Rake::Task.define_task(*args, &body)
end

class AppResourceTask
    # Known encoding/versions of VC++ app.rc
    ENCODING      = 'UTF-16LE'
    COMMA_PATTERN = /(\d+\,\d+\,\d+\,\d+)/ #=> version.gsub('.', ',')
    DOT_PATTERN   = /(\d+\.\d+\.\d+\.\d+)/ #=> version
    
    def execute(files, version)
        comma_pattern_e = regexp_encode(COMMA_PATTERN, ENCODING)
        dot_pattern_e   = regexp_encode(DOT_PATTERN, ENCODING)

        # Required options for read/write on Windows
        rx_opt = { mode: 'rb', encoding: "#{ENCODING}" }
        wx_opt = { mode: 'wb', encoding: "#{ENCODING}" }
            
        files.each do |file|
            content = File.read(file, rx_opt)
            
            puts "Updating #{file} to v#{version}"
            content.gsub!(comma_pattern_e, version.gsub('.', ',').encode(ENCODING))
            content.gsub!(dot_pattern_e, version.encode(ENCODING))
            
            File.open(file, wx_opt) { |f| f.write(content) }
        end
    end
    
    def regexp_encode(regex, encoding)
        Regexp.new(regex.to_s.encode(encoding))
    end
end