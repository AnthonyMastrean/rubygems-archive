def exec(*args, &block)
  config = Cli::Configuration.new
  block.call config
  
  body = proc {
    task = Cli::Task.new config
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Cli
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    
    def args
      p = []
      p << @parameters if @parameters
      p
    end
  end
  
  class Task
    def initialize(configuration)
      @statement = "#{configuration.command.quote} #{configuration.args.flatten.compact.join " "}"
      @working_directory = configuration.working_directory || Dir.pwd
    end
    
    def execute
      Dir.chdir @working_directory do 
        puts "#{@working_directory}> #{@statement}"
        system @statement
      end
    end
  end
end
