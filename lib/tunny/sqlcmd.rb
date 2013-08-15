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
      p = []
      p << "-S #{server}" if @server
      p << '-E' if @trusted
      p << "-i #{input_file.quote}" if @input_file # -i "/path/to/input/file"
      p << '-x' if @disable_variable_substitution
      p << "-v #{@variables.map { |k,v| "#{k}=#{v.quote}" }.join ' '}" if @variables unless @variables.empty? # -v var1="val1" var2="val2"
    end
    
    def trusted
      @trusted = true
    end
    
    def disable_variable_substitution
      @disable_variable_substitution = true
    end
  end
end
