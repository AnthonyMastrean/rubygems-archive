class InstallShieldTask
  def initialize(config)
    @project = IsmProject.new(config.ism)
    @command = CommandLine.new(config.command, config.make_parameters)
  end

  def execute
    @project.modify do |msi|
      msi.ProductVersion = config.product_version if config.product_version
      msi.ProductCode = config.product_code if config.product_code
      msi.ProductCode = msi.GenerateGUID if config.new_product_code
    end

    @command.execute
  end
end