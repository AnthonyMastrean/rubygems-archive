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
        puts "#{@working_directory}> #{@statement}"
        system @statement
      end
    end
  end
end
