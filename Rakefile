require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "jruby-gate"
    gemspec.summary = "A jruby wrapper library for the Gate Framework"
    gemspec.description = "Jruby library for accessing the Gate framwork"
    gemspec.email = "adam@dberg.org"
    gemspec.homepage = "http://github.com/denen99/jruby-gate"
    gemspec.authors = ["Adam Denenberg"]
    gemspec.files = ["README","Rakefile","jruby-gate.gem","lib/jruby-gate.rb"] + Dir["lib/jruby-gate/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

