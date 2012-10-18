require 'command_line'
require 'installshield_configuration'
require 'installshield_task'
require 'ism_project'

def installshield(*args)
  args ||= []

  config = InstallShield::InstallShieldConfiguration.new
  yield(config)
    
  body = proc {
    InstallShield::InstallShieldTask.new(config).execute
  }
    
  Rake::Task.define_task(*args, &body)
end