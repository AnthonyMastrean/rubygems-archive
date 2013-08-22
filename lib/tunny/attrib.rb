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
    attr_accessor :filename
  
    @map = { readonly: "R", archive: "A", system: "S", hidden: "H" }
  
    def args
      p = []
      p << @filename.quote
      p << @set.map { |o| "+#{@map[o]}" } if @set
      p << @clear.map { |o| "-#{@map[o]}" } if @clear
      p << "/S" if @recurse
      p << "/D" if @include_folders
      p << @parameters if @parameters
      p
    end
    
    def set(opts = [])
      @set = opts
    end
    
    def clear(opts = [])
      @clear = opts
    end
    
    def recurse
      @recurse = true
    end
    
    def include_folders
      @include_folders = true
    end
  end
end
