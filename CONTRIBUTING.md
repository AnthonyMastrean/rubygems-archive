All EXE wrappers should follow the same rules. Start with a new file in `lib/tunny`.

```bat
> notepad lib\tunny\ping.rb
```

A method in the global scope is required to get the fancy rake-like style. It takes the same arguments as the rake `task` method. We'll fill it in later.

```ruby
def ping(*args, &block)
  Rake::Task.define_task *args, &block
end
```

Every task needs a configuration object, to be yielded to the method call in the rakefile, so that the user can set the properties for this command. Always place the configuration class inside a module named after the EXE.

```ruby
module Ping
  class Configuration
  end
end
```

Always provide the following three read/write fields so that the user can set their own command path, working directory (this is occassionally necessary for native Windows EXEs), and any parameters that you don't take the time to specify.

```ruby
module Ping
  class Configuration
    attr_accessor :command, :parameters, :working_directory
  end
end
```

I find it useful to provide the default value for the command property. I use the name of the EXE, but without an extension, in case the user has PATHed it through a batch file or something (think of CLI Chocolatey packages). It also makes the default depend on the user setting up their own path.

```ruby
module Ping
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    
    def initialize
      @command = "ping"
    end
  end
end
```

If you're wrapping an EXE that really won't normally be on the path (what?) or can have multiple installed versions, and they have well-known paths, use module level constants. I'm completely making up this example, sorry. But, you get the idea.


```ruby
module Ping
  X86 = File.join ENV["WINDIR"], "system32", "ping.exe"
  X64 = File.join ENV["WINDIR"], "syswow64", "ping.exe"

  class Configuration
    attr_accessor :command, :parameters, :working_directory
    
    def initialize
      @command = "ping"
    end
  end
end
```

Provide regular read/write fields for EXE parameters that need to be assigned by the user. 

```ruby
module Ping
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :target, :count
    
    def initialize
      @command = "ping"
    end
  end
end
```

Define methods for "switch" parameters, which are parameters that are either present or not, with no value. Try to pick reasonable names. Assign a boolean with the same name. And, please, try to make it a positive assignment (=true).

```ruby
module Ping
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :target, :count
    
    def initialize
      @command = "ping"
    end
    
    def no_fragment
      @no_fragment = true
    end
  end
end
```

Wire up the required method, `args`, that will combine all of the user's configuration into the command line equivalent statement. You should basically shovel items into an array (remember to return it!) as they're set by the user.

 * Use the form `"#{foo}" if @foo"` to create optional configuration
 * For arrays that require string interpolation, like `"-files #{@files.map { ... }}"`, check if the array is empty or nil by doing `... unless files.empty? if files`. The order is outside-in.
 

```ruby
module Ping
  class Configuration
    attr_accessor :command, :parameters, :working_directory
    attr_accessor :target, :count
    
    def initialize
      @command = "ping"
    end

    def args
      p = []
      p << @target
      p << "-n #{@count}" if @count
      p << "-f" if @no_fragment
      p
    end
    
    def no_fragment
      @no_fragment = true
    end
  end
end
```

Now you can fill in your original task method! It's mostly the same for all wrappers.

```ruby
def ping(*args, &block)
  config = Ping::Configuration.new
  block.call config

  body = proc {
    cmd = Windows::Cli config.command, config.args, config.working_directory
    cmd.execute
  }

  Rake::Task.define_task *args, &body
end
```

If you have a task with an optional configuration (somehow your EXE can run bare), you should write the block call like this

```ruby
block.call config if block
```

Lastly, write up the wiki page and leave a safe example task in the example directory rakefile.

```ruby
ping :ping do |cmd|
  cmd.target = "localhost"
  cmd.count = 100
  cmd.no_fragment
end
```
