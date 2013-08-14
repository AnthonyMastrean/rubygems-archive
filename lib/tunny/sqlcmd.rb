def sqlcmd(*args, &block)
  config = Sqlcmd::Configuration.new
  block.call config
  
  body = proc { 
    cmd = Windows::Cli.new config.command, config.args, config.working_directory
    cmd.execute
  }
  
  Rake::Task.define_task *args, &body
end

module Sqlcmd
  class Configuration
    attr_accessor :command, :working_directory, :server, :input_file, :variables
    
    def initialize
      @command = 'sqlcmd'
    end
    
    def args
      # working/directory cmd> "path/to/sqlcmd.exe" -S server -E -i \"path/to/file.sql\" -x -v var1=\"value1\" var2="\value2\"
      p = []
      p << "-S #{server}" if @server
      p << '-E' if @trusted
      p << "-i #{input_file.quote}" if @input_file
      p << '-x' if @disable_variable_substitution
      p << "-v #{@variables.map { |k,v| "#{k}=#{v.quote}" }.join ' '}" if @variables unless @variables.empty?
    end
    
    def trusted
      @trusted = true
    end
    
    def disable_variable_substitution
      @disable_variable_substitution = true
    end
    
    def to_s
      args.join ' '
    end
  end
end

=begin
Microsoft (R) SQL Server Command Line Tool
Version 11.0.2100.60 NT x64
Copyright (c) 2012 Microsoft. All rights reserved.

usage: Sqlcmd            [-U login id]          [-P password]
  [-S server]            [-H hostname]          [-E trusted connection]
  [-N Encrypt Connection][-C Trust Server Certificate]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w screen width]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-c cmdend]            [-L[c] list servers[clean output]]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
  [-u unicode output]    [-r[0|1] msgs to stderr]
  [-i inputfile]         [-o outputfile]        [-z new password]
  [-f <codepage> | i:<codepage>[,o:<codepage>]] [-Z new password and exit]
  [-k[1|2] remove[replace] control characters]
  [-y variable length type display width]
  [-Y fixed length type display width]
  [-p[1] print statistics[colon format]]
  [-R use client regional setting]
  [-K application intent]
  [-M multisubnet failover]
  [-b On error batch abort]
  [-v var = "value"...]  [-A dedicated admin connection]
  [-X[1] disable commands, startup script, environment variables [and exit]]
  [-x disable variable substitution]
  [-? show syntax summary]
=end
