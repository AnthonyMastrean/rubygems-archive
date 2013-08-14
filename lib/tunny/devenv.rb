def devenv(*args, &block)
  config = Devenv::Configuration.new
  block.call config
  
  body = proc { 
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Devenv
  V11 = 'C:/Program Files (x86)/Microsoft Visual Studio 11.0/Common7/IDE/devenv.com'
  V10 = 'C:/Program Files (x86)/Microsoft Visual Studio 10.0/Common7/IDE/devenv.com'
  V9 = 'C:/Program Files (x86)/Microsoft Visual Studio 9.0/Common7/IDE/devenv.com'
  
  def initialize
    @command = 'devenv'
  end
  
  class Configuration
    attr_accessor :command, :working_directory, :solution, :target, :platform, :configuration
    
    def args
      # working/directory cmd> "path/to/devenv.exe" "foo.sln" /target "configuration|platform"
      p = []
      p << @solution.quote
      p << "/#{@target}"
      p << "#{@configuration}|#{@platform}".quote
    end
    
    def to_s
      args.join ' '
    end
  end
end

=begin
Microsoft (R) Microsoft Visual Studio 2012 Version 11.0.60610.1.
Copyright (C) Microsoft Corp. All rights reserved.

Use:
devenv  [solutionfile | projectfile | anyfile.ext]  [switches]

The first argument for devenv is usually a solution file or project file.
You can also use any other file as the first argument if you want to have the
file open automatically in an editor. When you enter a project file, the IDE
looks for an .sln file with the same base name as the project file in the
parent directory for the project file. If no such .sln file exists, then the
IDE looks for a single .sln file that references the project. If no such single
.sln file exists, then the IDE creates an unsaved solution with a default .sln
file name that has the same base name as the project file.

Command line builds:
devenv solutionfile.sln /build [ solutionconfig ] [ /project projectnameorfile [ /projectconfig name ] ]
Available command line switches:

/Build          Builds the solution or project with the specified solution
                configuration. For example "Debug". If multiple platforms
                are possible, the configuration name must be enclosed in quotes
                and contain platform name. For example: "Debug|Win32".
/Clean          Deletes build outputs.
/Command        Starts the IDE and executes the command.
/Deploy         Builds and then deploys the specified build configuration.
/Edit           Opens the specified files in a running instance of this
                application. If there are no running instances, it will
                start a new instance with a simplified window layout.
/LCID           Sets the default language in the IDE for the UI.
/Log            Logs IDE activity to the specified file for troubleshooting.
/NoVSIP         Disables the VSIP developer's license key for VSIP testing.
/Out            Appends the build log to a specified file.
/Project        Specifies the project to build, clean, or deploy.
                Must be used with /Build, /Rebuild, /Clean, or /Deploy.
/ProjectConfig  Overrides the project configuration specified in the solution
                configuration. For example "Debug". If multiple platforms are
                possible, the configuration name must be enclosed in quotes
                and contain platform name. For example: "Debug|Win32".
                Must be used with /Project.
/Rebuild        Cleans and then builds the solution or project with the
                specified configuration.
/ResetAddin     Removes commands and command UI associated with the specified Add-in.
/ResetSettings  Restores the IDE's default settings, optionally resets to
                the specified VSSettings file.
/ResetSkipPkgs  Clears all SkipLoading tags added to VSPackages.
/Run            Compiles and runs the specified solution.
/RunExit        Compiles and runs the specified solution then closes the IDE.
/SafeMode       Launches the IDE in safe mode loading minimal windows.
/Upgrade        Upgrades the project or the solution and all projects in it.
                A backup of these files will be created as appropriate.  Please
                see Help on 'Visual Studio Conversion Wizard' for more
                information on the backup process.

Product-specific switches:

/debugexe       Open the specified executable to be debugged. The remainder of
                the command line is passed to this executable as its arguments.
/diff           Compares two files.  Takes four parameters:
                SourceFile, TargetFile, SourceDisplayName(optional),
                TargetDisplayName(optional)
/TfsLink        Opens Team Explorer and launches a viewer for the
                provided artifact URI if one is registered.
/useenv         Use PATH, INCLUDE, LIBPATH, and LIB environment variables
                instead of IDE paths for VC++ builds.

To attach the debugger from the command line, use:
        VsJITDebugger.exe -p <pid>
=end
