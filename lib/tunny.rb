require 'tunny/version'
require 'tunny/devenv'
require 'tunny/sqlcmd'
require 'tunny/robocopy'
require 'tunny/writable'
require 'tunny/windows_cli'

module Tunny
  
end

class String
  def quote
    "\"#{self}\""
  end
end
