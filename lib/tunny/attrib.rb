def attrib(*args, &block)
  config = Attrib::Configuration.new
  block.call config

  body = proc { 
    cmd = Windows::Cli.new config
    cmd.execute
  }

  Rake::Task.define_task *args, &body
end

module Attrib
  OPTS = { readonly: "R", archive: "A", system: "S", hidden: "H" }

  class Configuration
    attr_accessor :command, :working_directory, :parameters
    attr_accessor :filename

    def initialize
      @command = "attrib"
    end
  
    def args
      p = []
      p << @set.map { |item| "+#{OPTS[item]}" } if @set
      p << @clear.map { |item| "-#{OPTS[item]}" } if @clear
      p << @filename.quote
      p << "/S" if @recurse
      p << "/D" if @include_folders
      p << @parameters if @parameters
      p
    end
    
    def set(opts)
      @set = opts
    end
    
    def clear(opts)
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
