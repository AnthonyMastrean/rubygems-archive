require_relative 'slowrcheetah/version'
require_relative 'slowrcheetah/apprc'
require_relative 'slowrcheetah/appconfig'

module Slowrcheetah
  
end

class Regexp
  def encode(encoding)
    Regexp.new self.to_s.encode encoding
  end
end
