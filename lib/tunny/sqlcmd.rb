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
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :server, :input_file, :variables
    
    def initialize
      @command = 'sqlcmd'
    end
    
    def args
      p = []
      p << "-S #{@server}" if @server
      p << '-E' if @trusted_connection
      p << "-i #{@input_file.quote}" if @input_file # -i "/path/to/input/file"
      p << '-x' if @disable_variable_substitution
      p << "-v #{@variables.map { |k,v| "#{k}=#{v.quote}" }.join ' '}" unless @variables.empty? if @variables # -v var1="val1" var2="val2"
      p << @parameters if @parameters
      p
    end
    
    def trusted_connection
      @trusted_connection = true
    end
    
    def disable_variable_substitution
      @disable_variable_substitution = true
    end
  end
end
