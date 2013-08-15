def writable(*args)
  file = args.first
  body = proc { File.chmod(644, file) if File.exists? file }
  Rake::Task.define_task *args, &body
end
