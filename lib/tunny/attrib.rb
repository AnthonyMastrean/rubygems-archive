def attrib(*args, &block)
  config = Attrib::Configuration.new
  block.call config

  body = proc { 
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute
  }

  Rake::Task.define_task *args, &body
end

module Attrib
  class Configuration
    attr_accessor :command, :working_directory, :parameters
    attr_accessor :filename, :readonly
  
    def args
      p = []
      p << @filename.quote
      p << "#{to_prefix @readonly}R"
      p << "/S" if @recurse
      p << "/D" if @include_folders
      p << @parameters if @parameters
      p
    end
    
    def recurse
      @recurse = true
    end
    
    def include_folders
      @include_folders = true
    end
    
    def to_prefix(val)
      val ? "+" : "-"
    end
  end
end
