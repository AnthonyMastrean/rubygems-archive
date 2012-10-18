module InstallShield
  class InstallShieldConfiguration
    attr_accessor :command, :parameters, :ism, :product_version, :product_code
    attr_reader :new_product_code

    def initialize
      @command = File.join ENV['ProgramFiles(x86)'], 'InstallShield/2010 StandaloneBuild/System/IsCmdBld.exe'
      @parameters = []
    end

    def new_product_code!
      @new_product_code = true
    end

    def make_parameters
      @parameters ||= []
      @parameters << "-p \"#{windows_path @ism}\""
      @parameters.flatten
    end

    def windows_path(path)
      path.gsub '/', '\\'
    end
  end
end