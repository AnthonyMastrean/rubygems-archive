module Robocopy

  class RobocopyConfiguration
    attr_accessor :command, :source, :destination, :files, :log, :log_append, :exclude_files, :exclude_dirs
    attr_reader :mirror, :tee, :dryrun
    
    def initialize
      @command = 'robocopy'
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
    
    def make_parameters
      parameters = [ @source, @destination ]
      parameters << @files.flatten if @files
      parameters << "/XF #{@exclude_files.flatten.join ' '}" if @exclude_files
      parameters << "/XD #{@exclude_dirs.flatten.join ' '}" if @exclude_dirs
      parameters << '/MIR' if @mirror
      parameters << '/TEE' if @tee
      parameters << "/LOG:#{@log}" if @log
      parameters << "/LOG+:#{@log_append}" if @log_append
      parameters << '/L' if @dryrun
      parameters.flatten
    end
  end

end
module Robocopy

  class RobocopyTask
    def initialize(command_line)
      @command_line = command_line
    end
    
    def execute
      # Robocopy has non-zero successful exit codes
      # http://ss64.com/nt/robocopy-exit.html
      @command_line.execute || $?.exitstatus < 8
    end
  end

end
