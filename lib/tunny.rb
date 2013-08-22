require_relative "tunny/attrib"
require_relative "tunny/devenv"
require_relative "tunny/sqlcmd"
require_relative "tunny/robocopy"
require_relative "tunny/version"
require_relative "tunny/windows_cli"

module Tunny
  
end

class String
  def quote
    "\"#{self}\""
  end
  
  def windows_path
    gsub "/", "\\"
  end
end
