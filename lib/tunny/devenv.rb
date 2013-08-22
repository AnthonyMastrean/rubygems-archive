def devenv(*args, &block)
  config = Devenv::Configuration.new
  block.call config
  
  body = proc { 
    cmd = Windows::Cli.new config
    cmd.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Devenv
  V11 = File.join ENV["VS110COMNTOOLS"], "..\\IDE\\devenv.com" if ENV["VS110COMNTOOLS"]
  V10 = File.join ENV["VS100COMNTOOLS"], "..\\IDE\\devenv.com" if ENV["VS100COMNTOOLS"]
  V9 = File.join ENV["VS90COMNTOOLS"], "..\\IDE\\devenv.com" if ENV["VS90COMNTOOLS"]

  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :solution, :target, :platform, :configuration
        
    def initialize
      @command = "devenv"
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
