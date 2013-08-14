module Windows
  class Cli
    attr_reader :statement, :working_directory
  
    def initialize(command, args, working_directory)
      @command = command.quote
      @args = args || []
      @working_directory = working_directory || Dir.pwd
      
      @statement = "#{@command} #{@args.join ' '}"
    end
    
    def execute
      Dir.chdir @working_directory do 
        puts to_s
        system @statement
      end
    end
    
    def to_s
      "#{@working_directory}> #{@statement}"
    end
  end
end
