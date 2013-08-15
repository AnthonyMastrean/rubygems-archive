def robocopy(*args, &block)
  config = Robocopy::Configuration.new
  block.call config
  
  body = proc { 
    # Robocopy has non-zero successful exit codes (http://ss64.com/nt/robocopy-exit.html)
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute || $?.exitstatus < 8
  }
  
  Rake::Task.define_task *args, &body
end

module Robocopy
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :source, :destination, :files, :log, :log_append, :exclude_files, :exclude_dirs
        
    def initialize
      @command = 'robocopy'
    end
    
    def args
      p = []
      p << @source
      p << @destination
      p << (@files.join ' ') if @files
      p << "/XF #{@exclude_files.join ' '}" if @exclude_files
      p << "/XD #{@exclude_dirs.join ' '}" if @exclude_dirs
      p << '/MIR' if @mirror
      p << '/TEE' if @tee
      p << "/LOG:#{@log}" if @log
      p << "/LOG+:#{@log_append}" if @log_append
      p << '/L' if @dryrun
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
end
