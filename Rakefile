#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rake/testtask"

task :default => :test

desc "Run unit tests"
task :test do
  Rake::TestTask.new { | task |
    task.pattern = 'test/test_*.rb'
    task.verbose = true
    task.options = '-v'
    task.warning = false
  }
end