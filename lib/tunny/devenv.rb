def devenv(*args, &block)
  config = Devenv::Configuration.new
  block.call config
  
  body = proc { 
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Devenv
  V11 = 'C:/Program Files (x86)/Microsoft Visual Studio 11.0/Common7/IDE/devenv.com'
  V10 = 'C:/Program Files (x86)/Microsoft Visual Studio 10.0/Common7/IDE/devenv.com'
  V9 = 'C:/Program Files (x86)/Microsoft Visual Studio 9.0/Common7/IDE/devenv.com'

  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :solution, :target, :platform, :configuration
        
    def initialize
      @command = 'devenv'
    end
    
    def args
      p = []
      p << @solution.quote
      p << "/#{@target}" if @target
      p << "#{@configuration}|#{@platform}".quote if @configuration and @platform
      p << @parameters if @parameters
      p
    end
  end
end
