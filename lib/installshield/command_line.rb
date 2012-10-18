class CommandLine
  def initialize(executable, parameters = [])
    @executable = escape_string executable
    @parameters = parameters.join ' '
  end

  def execute
    command = "#{@executable} #{@parameters}"
    puts "Executing: #{command}"
    system command
  end

  def escape_string(val)
    "\"#{val}\""
  end
end