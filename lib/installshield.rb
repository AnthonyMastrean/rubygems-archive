require_relative 'installshield/command_line'
require_relative 'installshield/installshield_configuration'
require_relative 'installshield/installshield_task'
require_relative 'installshield/ism_project'

def installshield(*args)
  args ||= []

  config = InstallShield::InstallShieldConfiguration.new
  yield(config)
    
  body = proc {
    project = InstallShield::IsmProject.new(config.ism)
    command = InstallShield::CommandLine.new(config.command, config.make_parameters)
    InstallShield::InstallShieldTask.new(config, project, command).execute
  }
    
  Rake::Task.define_task(*args, &body)
end