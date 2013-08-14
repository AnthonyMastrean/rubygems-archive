def sqlcmd(*args, &block)
  config = Sqlcmd::Configuration.new
  block.call config
  
  body = proc { 
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Sqlcmd
  class Configuration
    attr_accessor :command, :working_directory, :server, :input_file, :variables
    
    def initialize
      @command = 'sqlcmd'
    end
    
    def args
      # working/directory cmd> "path/to/sqlcmd.exe" -S server -E -i \"path/to/file.sql\" -x -v var1=\"value1\" var2="\value2\"
      p = []
      p << "-S #{server}" if @server
      p << '-E' if @trusted
      p << "-i #{input_file.quote}" if @input_file
      p << '-x' if @disable_variable_substitution
      p << "-v #{@variables.map { |k,v| "#{k}=#{v.quote}" }.join ' '}" if @variables unless @variables.empty?
    end
    
    def trusted
      @trusted = true
    end
    
    def disable_variable_substitution
      @disable_variable_substitution = true
    end
    
    def to_s
      args.join ' '
    end
  end
end
