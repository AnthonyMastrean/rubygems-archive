# InstallShield Rake Tasks

Modify and build InstallShield 2010 projects.

## Installation

Add this line to your application's Gemfile:

    gem 'installshield'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install installshield

## Usage
You must `require 'installshield'` to get access to the custom rake task, `installshield`.

    require 'installshield'

Then, you can declare the task and provide a name (normal Rake stuff) and a block.

    installshield :msi do |msi|
      # ...
    end
    
This block has several parts. Some work together and some are mutually exclusive. Use the Unix directory separator (`/`) unless otherwise specified.

You may override the path to the InstallShield builder (`IsCmdBld.exe`), or we will use the one installed in `ProgramFiles(x86)`.

    msi.command = 'path/to/your/builder.exe'
    
You must provide an ISM project path.

    msi.ism = 'path/to/project.ism'
    
You may provide any extra parameters to the command. The `parameters` is an empty array. You can shovel into it.
    
    msi.parameters << "-l PATH_TO_RELEASE_FILES=\".\\bin\Release\""

Or overwrite it.

    msi.parameters = [ "-l PATH_TO_RELEASE_FILES=\".\\bin\Release\"" ]

If you put file paths in the `parameters`, InstallShield requires the Windows directory separator (`\\`). The configuration object given in the block has a helper method `windows_path(string)` that you can use. This is especially helpful if your paths have Unix slashes and are stored in variables used elsewhere.

    msi.paramters << "-l PATH_TO_RELEASE_FILES=\"#{msi.windows_path output_path}\""

We take care of the ISM project path argument (`-p`) which is required by the builder (and we automatically `windows_path` it).

    "-p \"#{windows_path 'path/to/project.ism'}\""

That's all you need to build an existing ISM project! Putting it all together

    require 'installshield'
    
    installshield :msi do |msi|
      msi.ism 'path/to/project.ism'
      msi.parameters << "-l PATH_TO_RELEASE_FILES=\"#{msi.windows_path output_path}\""
    end

However, there are projects where you need to increment the product version. For that, you can provide the version string.

    msi.product_version = '0.0.5.0'

You can also provide the product code directly (remember, InstallShield expects a UUID wrapped in squiggly brackets, `{my-guid}`).

    msi.product_code = '{91fcd14f-4274-485c-902d-2555012bbb3f}'

Or, if you want the InstallShield system to generate a UUID for you, using their internal methods, say

    msi.new_product_code!

Those are all the properties that we let you change right now. All together, again... 

    require 'installshield'
    
    installshield :msi do |msi|
      msi.ism 'path/to/project.ism'
      msi.parameters << "-l PATH_TO_RELEASE_FILES=\"#{msi.windows_path output_path}\""
      msi.product_version = version
      msi.new_product_code!
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
