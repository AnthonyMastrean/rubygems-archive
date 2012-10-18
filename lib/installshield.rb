require 'command_line'
require 'installshield_configuration'
require 'installshield_task'
require 'ism_project'

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