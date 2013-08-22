def robocopy(*args, &block)
  config = Robocopy::Configuration.new
  block.call config
  
  body = proc {     
    task = Robocopy::Task.new Cli::Task.new config
    task.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Robocopy
  class Configuration < Cli::Configuration
    attr_accessor :source, :destination, :files, :log, :exclude_files, :exclude_dirs
        
    def initialize
      @command = "robocopy"
    end
    
    def args
      p = []
      p << @source
      p << @destination
      p << (@files.join " ") if @files
      p << "/XF #{@exclude_files.join " "}" if @exclude_files
      p << "/XD #{@exclude_dirs.join " "}" if @exclude_dirs
      p << "/MIR" if @mirror
      p << "/TEE" if @tee
      p << "/LOG:#{@log}" if @log
      p << "/L" if @dryrun
      p << @parameters if @parameters
      p
    end

    def mirror
      @mirror = true
    end

    def tee
      @tee = true
    end
    
    def dryrun
      @dryrun = true
    end
  end
  
  class Task
    def initialize(task)
      @task = task
    end
    
    def execute
      # Robocopy has non-zero successful exit codes (http://ss64.com/nt/robocopy-exit.html)
      @task.execute || $?.exitstatus < 8
    end
  end
end
