# Slowcheetr

Windows and .NET configuration file (XML) transforms for rake.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slowcheetr'
```

And then execute:

```powershell
> bundle
```

Or install it yourself as:

```powershell
> gem install slowcheetr
```

## Usage

Require the gem at the top of your rakefile

```ruby
require "slowcheetr"
```

The app resource task is the simplest, only allowing you to modify the `version`

```ruby
apprc :apprc do |app|
  app.filename = "app.rc"
  app.version = "1.0.0"
end
```

The app config task is, currently, a full-service XPath replacement engine!

```ruby
appconfig :appconfig do |app|
  app.filename = "app.exe.config"
  app.replacements = {
    "/configuration/applicationSettings/*/setting[@name=\"FullScreen\"]/value" => "True",
    "/configuration/applicationSettings/*/setting[@name=\"Profile\"]/value" => "Simluation"
  }
end
```

You can change all of your app resource or config files by using wildcards and dynamic task declaration.

```ruby
FileList["source/**/*.rc"].each do |file|
  apprc file do |app|
    app.filename = file
    app.version = "1.0.0"
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
