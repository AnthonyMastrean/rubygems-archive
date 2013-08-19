# Tunny

Simple rake task wrappers for Windows developer EXEs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tunny'
```

And then execute:

```bat
> bundle
```

Or install it yourself as:

```bat
> gem install tunny
```

## Usage

Require the gem at the top of your rakefile.

```ruby
require 'tunny'
```

And you'll have access to all of the EXE wrappers. Please reference each task's wiki page for it's usage.

 * `devenv`
 * `sqlcmd`
 * `robocopy`

There's one other task that's not an EXE wrapper, but is essential to using rake for TFS systems... `writable`. It looks like the built-in `file` task, but please check the wiki page.

```ruby
writable 'source/CommonAssemblyInfo.cs'
```
