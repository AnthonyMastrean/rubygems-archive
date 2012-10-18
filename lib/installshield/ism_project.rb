module InstallShield
  require 'win32ole'

  class IsmProject
    def initialize(ism)
      @project = WIN32OLE.new 'ISWiAuto16.ISWiProject'
      @ism = ism
    end

    def modify
      @project.OpenProject @ism
      yield(@project) if block_given?
      puts "MSI:: #{@ism} v#{@project.ProductVersion} #{@project.ProductCode}"
      @project.SaveProject
      @project.CloseProject
    end
  end
end