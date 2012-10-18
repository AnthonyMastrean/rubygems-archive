lib = File.dirname(File.expand_path(__FILE__))
Dir.glob(File.join(lib, '/installshield/*.rb')).each do |file|
  require file
end

def installshield(*args)
  args ||= []

  config = InstallShieldConfiguration.new
  yield(config)
    
  body = proc {
    InstallShieldTask.new(config).execute
  }
    
  Rake::Task.define_task(*args, &body)
end