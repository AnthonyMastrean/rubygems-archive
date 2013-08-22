require_relative "tunny/cli"

require_relative "tunny/attrib"
require_relative "tunny/devenv"
require_relative "tunny/sqlcmd"
require_relative "tunny/robocopy"

require_relative "tunny/version"

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
