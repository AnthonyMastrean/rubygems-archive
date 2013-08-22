module Windows
  class Cli
    def initialize(command, args, working_directory)
      @command = command
      @args = args.flatten.compact
      @working_directory = working_directory || Dir.pwd
    end
    
    def execute
      Dir.chdir @working_directory do 
        puts "#{@working_directory}> #{@command} #{@args.join ' '}"
        system @command, *@args
      end
    end
  end
end
