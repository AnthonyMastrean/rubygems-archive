All application wrappers should follow the same rules. Start with a new file in `lib/tunny`.

```bat
> notepad lib\tunny\ping.rb
```

A method in the global scope is required to get the fancy rake-like style. It takes the same arguments as the rake `task` method. We'll fill it in later.

```ruby
def ping(*args, &block)
  Rake::Task.define_task *args, &block
end
```

Every task needs a configuration object to be yielded to it in the rakefile. Always place the configuration class inside a module named after the application. Inherit from `Cli::Configuration` to get the default properties (`:command`, `:parameters`, `:working_directory`). If the application is expected to be on the user's PATH, override the command property in the constructor.

```ruby
module Ping
  class Configuration < Cli::Configuration
    def initialize
      @command = "ping"
    end
  end
end
```

If the application isn't normally be on the PATH, or has many versions, and they have well-known paths, use module constants. I'm completely making up this example, sorry. But, you get the idea.


```ruby
module Ping
  X86 = File.join ENV["WINDIR"], "system32", "ping.exe"
  X64 = File.join ENV["WINDIR"], "syswow64", "ping.exe"

  class Configuration < Cli::Configuration
    def initialize
      @command = "ping"
    end
  end
end
```

Provide read/write properties for the parameters that need to be assigned by the user. Define methods for "switch" parameters (on/off). Prefer to make the methods "positive" (turning something on or setting something true). And try to keep the names as close to the CLI reference as possible. 

```ruby
module Ping
  class Configuration < Cli::Configuration
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

Wire up the required method, `args`, to build up each of the command line parameters. Start by assigning an empty array. Always add the default `@parameters` at the end. And return the array! Don't depend on implicit return, what if the last statement evauluates `false`? In between, add your parameters in order, escaping and transforming, as necessary.

 * Use the form `"#{foo}" if @foo"` to create optional configuration
 * For arrays that require string interpolation, like `"-files #{@files.map { ... }}"`, check if the array is empty or nil by doing `... unless files.empty? if files`. The order is outside-in.
 * Don't over guard, check, or fiddle with the array, we'll get it at the end.

```ruby
module Ping
  class Configuration < Cli::Configuration
    attr_accessor :target, :count
    
    def initialize
      @command = "ping"
    end

    def args
      p = []
      p << @target
      p << "-n #{@count}" if @count
      p << "-f" if @no_fragment
      p << @parameters if @parameters
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
    task = Cli::Task.new config
    task.execute
  }

  Rake::Task.define_task *args, &body
end
```

If you have a task with an optional configuration (somehow your application can run bare), you should write the block call like this, or it will fail when the user does not provide a block.

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
