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

    require 'installshield'

    installshield :msi do |msi|
      msi.ism = './install/myproject.ism'
      msi.parameters << "-l PATH_TO_RELEASE_FILES=\".\\bin\Release""
      msi.product_version = '0.0.5.0'
      msi.new_product_code!
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
