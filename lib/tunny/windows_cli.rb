module Windows
  class Cli
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
